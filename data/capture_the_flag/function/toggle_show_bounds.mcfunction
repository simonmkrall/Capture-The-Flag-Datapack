# Flip the boundary particle overlay on/off (0 -> 1 -> 0) and report the state.
scoreboard players add show_bounds ctf 1
scoreboard players operation show_bounds ctf %= two ctf
execute if score show_bounds ctf matches 1 run tellraw @s [{"text":"Boundary overlay ","color":"gray"},{"text":"ON","color":"green"},{"text":". Run /trigger ShowBounds again to hide it.","color":"gray"}]
execute if score show_bounds ctf matches 0 run tellraw @s [{"text":"Boundary overlay ","color":"gray"},{"text":"OFF","color":"red"},{"text":".","color":"gray"}]
