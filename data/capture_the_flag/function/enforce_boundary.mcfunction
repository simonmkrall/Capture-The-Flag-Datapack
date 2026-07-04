# Keep each player inside their team's convex boundary area.
# Assume everyone is inside; the per-team polygon checks mark anyone outside.
scoreboard players set @a inside_boundary 1

# Only test a team once its area has been closed (edges are built).
execute if score red_closed ctf matches 1 as @a[team=Red] run function capture_the_flag:check_red
execute if score blue_closed ctf matches 1 as @a[team=Blue] run function capture_the_flag:check_blue

# Punish players outside their territory, and clear effects when they return.
execute as @a if score @s inside_boundary matches 0 run effect give @s minecraft:weakness infinite 255 true
execute as @a if score @s inside_boundary matches 1 run effect clear @s

# While the ShowBounds overlay is on, ping anyone who just stepped across their
# boundary line. The prev_inside guard (0..1) skips players with no prior state
# yet, so a freshly joined player never fires a spurious cue on their first tick.
execute if score show_bounds ctf matches 1 as @a at @s if score @s prev_inside matches 0..1 unless score @s inside_boundary = @s prev_inside run function capture_the_flag:boundary_crossed

# Remember this tick's inside/outside state so the next tick can detect a change.
scoreboard players operation @a prev_inside = @a inside_boundary
