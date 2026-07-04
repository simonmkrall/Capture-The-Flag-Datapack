# Remove the most recently added Red vertex (in case you misplaced one).
execute if data storage capture_the_flag:poly red_verts[0] run data remove storage capture_the_flag:poly red_verts[-1]

# The area must be re-closed after editing its points.
scoreboard players set red_closed ctf 0
tellraw @s [{"text":"Removed the last Red point. Re-close with /trigger RClose when ready.","color":"red"}]
