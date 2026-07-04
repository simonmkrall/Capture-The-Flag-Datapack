# Capture The Flag

A Minecraft datapack for running a two-team capture-the-flag game. It creates Red and Blue teams, lets players join with trigger commands, tracks team scores in the sidebar, handles flag pickup/capture/return logic, and gives players a standard PvP kit.

This pack is built for datapack format `101`.

## Quick Start

1. Put this folder in a world's `datapacks` folder.
2. Run `/reload`, or restart the world/server.
3. Use `/trigger Info` any time to show the clickable setup guide in chat.
4. Set each team's territory by walking its border and dropping a boundary point at every corner, then closing the shape.
5. Join teams, place flags, get kits, and play.

## Arena Setup

Each team's territory is a **convex polygon** with any number of corners (3 or more). You define it by walking the border and dropping a point at each corner, then closing the loop. Boundary checks use X and Z only (height is ignored).

Walk the Red border and, at each corner, add a point; then close the area:

```mcfunction
/trigger RAddPoint   (repeat at every corner, going around one way)
/trigger RClose
```

Do the same for Blue:

```mcfunction
/trigger BAddPoint   (repeat at every corner, going around one way)
/trigger BClose
```

If you misplace a point, `/trigger RUndo` (or `BUndo`) removes the last one, and `/trigger RClear` (or `BClear`) starts that team's area over. You must re-close an area after editing its points.

To check your work, `/trigger ShowBounds` toggles a particle overlay that traces each closed area — red particles for the Red boundary, blue for the Blue boundary. Run it again to hide the overlay. Only closed areas are drawn, so it doubles as a quick way to confirm a `RClose`/`BClose` actually took.

While the overlay is on, players also get a **crossing cue** each time they step over their own boundary line: a warning note plus a flame/smoke burst when leaving their territory, and a bright bell plus sparkles when returning. The cue only fires while `ShowBounds` is on, so it never interrupts normal play — it's purely a setup/testing aid.

**Rules for a valid area:**

- Drop at least 3 points that actually enclose an area (points all in a straight line are rejected).
- The order you drop points in **does not matter**, and you don't have to avoid dents: on close, the area is reduced to the **convex hull** of your points — the smallest convex shape containing them all. Any inward dent is filled in automatically. If some points get absorbed this way, the close message tells you how many were used.

Because of the hull step, the enforced area is always convex, and it's exactly what the `ShowBounds` overlay draws — so what you see is what's enforced.

**How detection works:** closing the area computes the convex hull of your points and turns that ring into edge vectors. Each tick, for every player, the pack computes a 2D cross product against each edge; a point inside a convex polygon lies on the same side of every edge, so a player who ends up on both sides of different edges is flagged as outside. All of it is integer scoreboard math on vertex-relative differences, which keeps the numbers small even at large world coordinates. For a plain-language, freshman-math walkthrough, see [docs/boundary-detection.md](docs/boundary-detection.md).

Place each flag while standing where the flag should go:

```mcfunction
/trigger PlaceRedFlag
/trigger PlaceBlueFlag
```

Only Red players can place the Red flag, and only Blue players can place the Blue flag.

## Player Commands

| Command | What it does |
| --- | --- |
| `/trigger Info` | Shows the setup guide again. |
| `/trigger RedTeam` | Joins the Red team. |
| `/trigger BlueTeam` | Joins the Blue team. |
| `/trigger LeaveTeam` | Leaves the current team. |
| `/trigger Kit` | Gives the standard kit. This clears the player's inventory first. |
| `/trigger PlaceRedFlag` | Places or moves the Red flag at the player's location. |
| `/trigger PlaceBlueFlag` | Places or moves the Blue flag at the player's location. |

## Kit

Running `/trigger Kit` clears the player's inventory and gives:

- Unbreakable iron sword
- Unbreakable Power II bow
- 160 arrows
- 128 cooked beef
- Full unbreakable iron armor
- Unbreakable shield

Each player can receive the kit once per load unless their `kit_given` tag is reset.

## Gameplay Rules

- The Red team captures the Blue flag by carrying it back inside Red territory.
- The Blue team captures the Red flag by carrying it back inside Blue territory.
- Scores are shown in the sidebar under `Points`.
- A flag carrier glows and wears the stolen flag as a banner helmet.
- If a flag carrier dies, the flag returns to its home marker.
- Players outside their own territory receive high-level weakness.
- Arrows fired while outside the player's own territory are removed.
- Friendly fire is disabled.
- Enemy nametags are hidden.
- `keepInventory` is enabled while the datapack is loaded.

## Admin Commands

Reload and reset the game state:

```mcfunction
/reload
```

End the current game:

```mcfunction
/trigger Disable_Game
```

`Disable_Game` clears player inventories, removes the `Points` objective, clears effects, removes the Red and Blue teams, and announces that the game is over.

To fully disable the datapack after ending the game, use Minecraft's datapack command for this pack in your world.

## File Overview

| Path | Purpose |
| --- | --- |
| `pack.mcmeta` | Datapack metadata and supported pack format. |
| `data/minecraft/tags/function/load.json` | Runs `capture_the_flag:load` on reload. |
| `data/minecraft/tags/function/tick.json` | Runs `capture_the_flag:tick` every tick. |
| `data/capture_the_flag/function/load.mcfunction` | Creates objectives, teams, triggers, sidebar scores, gamerules, and setup chat. |
| `data/capture_the_flag/function/tick.mcfunction` | Main game loop for triggers, boundaries, flags, scoring, and cleanup. |
| `data/capture_the_flag/function/enforce_boundary.mcfunction` | Runs the per-team polygon check each tick and marks players inside or outside their own territory. |
| `data/capture_the_flag/function/add_red_point.mcfunction` / `add_blue_point.mcfunction` | Append the player's position as the next boundary corner. |
| `data/capture_the_flag/function/close_red_poly.mcfunction` / `close_blue_poly.mcfunction` | Reduce a team's points to their convex hull, build edge vectors, and activate its boundary. |
| `data/capture_the_flag/function/hull_compute.mcfunction` (+ `hull_find_start` / `hull_march` / `hull_scan` / `hull_consider` / `hull_take` / `hull_maybe`) | Gift-wrapping convex hull of the walked points, shared by both teams. |
| `data/capture_the_flag/function/build_red_edges.mcfunction` / `build_blue_edges.mcfunction` | Recursively compute the edge vectors from the vertex list. |
| `data/capture_the_flag/function/check_red.mcfunction` / `check_blue.mcfunction` / `check_poly_loop.mcfunction` | Point-in-convex-polygon test for a single player. |
| `data/capture_the_flag/function/undo_red_point.mcfunction` / `clear_red_poly.mcfunction` (and Blue) | Remove the last corner or clear a team's area. |
| `data/capture_the_flag/function/visualize_boundary.mcfunction` (+ `draw_*` / `draw_particle_*`) | Trace each closed boundary with colored particles while the `ShowBounds` overlay is on. |
| `data/capture_the_flag/function/boundary_crossed.mcfunction` (+ `boundary_cross_out` / `boundary_cross_in`) | Sound/particle cue when a player crosses their boundary line, only while `ShowBounds` is on. |
| `data/capture_the_flag/function/check_flags.mcfunction` | Handles flag pickup, capture checks, and carrier glow. |
| `data/capture_the_flag/function/kit.mcfunction` | Gives the standard player kit. |
| `data/capture_the_flag/function/disable.mcfunction` | Ends the game and removes active CTF state. |

## Development Notes

- Commands are namespaced under `capture_the_flag`.
- Shared datapack values (including boundary math scratch scores and the `red_closed` / `blue_closed` flags) are stored as holders in the `ctf` scoreboard objective.
- Boundary polygons live in command storage `capture_the_flag:poly` as `red_verts` / `blue_verts` (corner lists) and `red_edges` / `blue_edges` (precomputed edge vectors). They reset on every load.
- Trigger objectives are re-enabled every tick so players can use `/trigger` commands repeatedly.
- Flag home positions are stored as marker entities tagged `red_flag_home` and `blue_flag_home`.
- Team scores are fake players named `Red` and `Blue` in the `Points` objective.
