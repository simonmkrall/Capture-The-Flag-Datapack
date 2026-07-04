# How the Boundary Detection Works

This doc explains, in plain language, how the datapack decides whether a player
is **inside** their team's territory. You only need high-school-freshman math:
subtraction, multiplication, and the idea of "left vs. right." No trigonometry,
no calculus.

## The problem

Each team's territory is a shape drawn on the ground — a triangle, a rectangle,
a pentagon, whatever. Players stand at some spot, and every tick we need to
answer one yes/no question:

> Is this player standing inside the shape, or have they wandered outside it?

If they're outside, the pack hits them with weakness until they come back.

We only care about the flat ground plane, so we ignore height (Y). Every point
is just an **X** (east–west) and a **Z** (north–south), like a dot on graph
paper.

## The key idea: "same side of every wall"

Think of the shape's outline as a loop of straight **walls** (we call them
*edges*). You set them up by walking your border and dropping a point at each
corner; connecting the corners in order gives the walls.

Here's the trick that makes everything work, and it **only works for convex
shapes** (shapes with no dents — more on that later):

> Stand inside a convex shape and look at any one wall. The whole rest of the
> shape — and you with it — is on **one side** of that wall's line. That's true
> for *every* wall. So if you are on the "inside" side of every single wall at
> once, you must be inside the shape.
>
> If you've stepped outside, then at least one wall now has you on its **wrong
> (outside) side**.

So the entire test boils down to: **for each wall, which side of it is the
player on?** If the answer is "the same side" for all walls, they're inside.

```
        wall A
   -----------------
   |               |
   | wall D    •P  | wall B     P is on the inside side of A, B, C, and D
   |               |            --> P is INSIDE
   -----------------
        wall C
```

## How do we tell which side of a line a point is on?

This is the one piece of real math, and it's just one formula.

Picture a single wall. It starts at a corner **A** and runs to the next corner
**B**. That gives us a direction — an arrow pointing from A to B. Call the
arrow's change in X and change in Z:

```
dx = B.x - A.x        (how far the wall goes east)
dz = B.z - A.z        (how far the wall goes south)
```

Now take the player at point **P**. Draw a second arrow, from the wall's start
**A** out to the player **P**:

```
px - A.x              (how far east the player is from A)
pz - A.z              (how far south the player is from A)
```

We want to know: is the player's arrow turning to the **left** of the wall's
arrow, or to the **right**? There's a classic formula that answers exactly this,
called the **2D cross product**:

```
cross = dx * (pz - A.z)  -  dz * (px - A.x)
```

Don't worry about memorizing why those exact terms are multiplied and
subtracted. Here's all you need to know about the result:

- **cross is positive** → the player is on one side (say, the left).
- **cross is negative** → the player is on the other side (the right).
- **cross is zero** → the player is standing exactly *on* the wall's line.

The actual number doesn't matter — only its **sign** (+, −, or 0). The sign is
the whole answer to "which side?"

### A tiny numeric example

Say a wall goes from corner **A = (0, 0)** straight east to **B = (10, 0)**.
Then `dx = 10` and `dz = 0`.

- Player at **(5, 3)** — three blocks "below" the wall on the graph:
  `cross = 10 * (3 - 0) - 0 * (5 - 0) = 30`. Positive → one side.
- Player at **(5, -3)** — three blocks "above" the wall:
  `cross = 10 * (-3 - 0) - 0 * (5 - 0) = -30`. Negative → the other side.
- Player at **(5, 0)** — right on the wall:
  `cross = 10 * (0 - 0) - 0 * (5 - 0) = 0`. Zero → on the line.

Notice we never had to know which side is "inside." We just get a sign.

## Putting it together

For a given player, we walk around the shape and compute `cross` for **every**
wall. We don't need to decide ahead of time which sign means "inside." We just
watch the signs roll in:

- If **every** wall gives the same sign (all positive, or all negative, with any
  zeros ignored as "on the edge, close enough"), the player is on the same side
  of everything → **inside**.
- If we ever see **both** a positive sign *and* a negative sign among the walls,
  the player is on the inside of some walls but the outside of others → they must
  have crossed a wall → **outside**.

That's the entire algorithm:

> Compute the sign of `cross` for each wall. Saw both a `+` and a `−`? Outside.
> Otherwise, inside.

Because a rectangle is just a convex shape with four walls, this handles your old
rectangular arenas too — they're not a special case anymore.

## Why the shape has to be convex

**Convex** means the shape has no dents — no part of the outline caves inward.
Rectangles, triangles, regular hexagons, and stop-sign shapes are all convex. An
L-shape, a star, or a crescent are **concave** (they have dents).

The "same side of every wall" trick relies on the whole shape sitting neatly on
one side of each wall's line. A dent breaks that promise: you can be genuinely
inside an L-shaped room while sitting on the "outside" side of a wall that
belongs to the far leg of the L. So the test would wrongly call you "outside."

## The fix: snap to the convex hull at close time

Rather than trust the person to draw a convex shape, the pack **makes** the shape
convex when you close it. It computes the **convex hull** of the points you
dropped — the smallest convex shape that still contains all of them. Picture
stretching a rubber band around your points and letting it snap tight: the
outline it settles into is the hull.

- If your points already form a convex shape, the hull is exactly that shape —
  nothing changes.
- If you drew a dent, the hull ignores the inward point and "fills in" the dent,
  giving the smallest convex area that covers everything you marked.
- Points that end up inside the hull, or exactly on one of its edges, are simply
  dropped — they aren't needed to describe the shape.

Two nice side effects:

1. **Order doesn't matter.** A rubber band around a set of nails settles into the
   same shape no matter what order you hammered the nails in, so you can drop
   your corner points in any order.
2. **What you see is what's enforced.** The `ShowBounds` particle overlay draws
   the hull's walls — the exact same walls the inside/outside test uses — so the
   picture can never disagree with the rule.

The pack finds the hull with a method called **gift wrapping**: start at the
left-most point (definitely a corner), then repeatedly ask "from where I'm
standing, which point is the furthest to the right?" and walk to it, like
wrapping a string around the outside of the points until you arrive back at the
start. Each "furthest to the right" question is answered with the same
which-side-of-the-line cross product from earlier.

## How this maps to the datapack files

The math above is spread across a few small functions:

| File | What it does |
| --- | --- |
| `add_red_point` / `add_blue_point` | Records a corner (an X, Z pair) each time you drop a point while walking the border. |
| `close_red_poly` / `close_blue_poly` | When you finish, snaps your points to their convex hull, then turns the resulting ring of corners into walls. |
| `hull_compute` (+ `hull_find_start` / `hull_march` / `hull_scan` / `hull_consider` / `hull_take` / `hull_maybe`) | The gift-wrapping convex hull described above. |
| `build_red_edges` / `build_blue_edges` | For each wall, stores its start corner `(A.x, A.z)` and its direction `(dx, dz) = B - A`. This is done **once** at close time, so the per-tick work stays cheap. |
| `check_red` / `check_blue` | For one player: grabs their `(px, pz)`, then loops over the walls. |
| `check_poly_loop` | The heart of it: for one wall, computes `cross = dx*(pz - A.z) - dz*(px - A.x)`, then notes whether the sign was positive or negative. |
| `enforce_boundary` | Runs the check for everyone each tick and applies (or clears) weakness based on the inside/outside answer. |

Inside `check_poly_loop`, the code tracks two flags as it visits the walls:

- `any_pos` — did we see a positive cross on any wall?
- `any_neg` — did we see a negative cross on any wall?

After all walls are checked, the rule is simply:

```
if any_pos AND any_neg  ->  player is OUTSIDE
otherwise               ->  player is INSIDE
```

## One neat detail: the numbers stay small

Minecraft worlds can have coordinates in the millions. If we plugged raw
coordinates into a multiplication, the results could get enormous and overflow
the scoreboard's number limit.

But look again at the formula — every piece is a **difference**:

- `dx` and `dz` are one corner minus the next corner → at most the size of your
  arena (maybe a few hundred blocks).
- `pz - A.z` and `px - A.x` are the player minus a corner → also at most arena-
  sized, since players are near the arena.

So even if your arena sits at X = 2,000,000, the numbers actually multiplied are
small (a few hundred times a few hundred). Subtracting first, then multiplying,
keeps everything comfortably in range. No overflow, no rounding tricks needed.
