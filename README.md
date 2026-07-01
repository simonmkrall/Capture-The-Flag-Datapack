# Capture The Flag

A Minecraft datapack for running a two-team capture-the-flag game. It creates Red and Blue teams, lets players join with trigger commands, tracks team scores in the sidebar, handles flag pickup/capture/return logic, and gives players a standard PvP kit.

This pack is built for datapack format `101`.

## Quick Start

1. Put this folder in a world's `datapacks` folder.
2. Run `/reload`, or restart the world/server.
3. Use `/trigger Info` any time to show the clickable setup guide in chat.
4. Set both teams' territories by standing at opposite corners of each base area and running the corner triggers.
5. Join teams, place flags, get kits, and play.

## Arena Setup

Territories are rectangular areas defined by two opposite corners. The datapack stores X, Y, and Z when a corner is set, but boundary checks currently use X and Z only.

Set the Red territory:

```mcfunction
/trigger RCorner1
/trigger RCorner2
```

Set the Blue territory:

```mcfunction
/trigger BCorner1
/trigger BCorner2
```

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
| `data/capture_the_flag/function/enforce_boundary.mcfunction` | Calculates territory bounds and marks players inside or outside their own territory. |
| `data/capture_the_flag/function/check_flags.mcfunction` | Handles flag pickup, capture checks, and carrier glow. |
| `data/capture_the_flag/function/kit.mcfunction` | Gives the standard player kit. |
| `data/capture_the_flag/function/disable.mcfunction` | Ends the game and removes active CTF state. |

## Development Notes

- Commands are namespaced under `capture_the_flag`.
- Shared datapack values are stored in the `ctf` scoreboard objective.
- Trigger objectives are re-enabled every tick so players can use `/trigger` commands repeatedly.
- Flag home positions are stored as marker entities tagged `red_flag_home` and `blue_flag_home`.
- Team scores are fake players named `Red` and `Blue` in the `Points` objective.
