# Remove the most recently added Blue vertex (in case you misplaced one).
execute if data storage capture_the_flag:poly blue_verts[0] run data remove storage capture_the_flag:poly blue_verts[-1]

# The area must be re-closed after editing its points.
scoreboard players set blue_closed ctf 0
tellraw @s [{"text":"Removed the last Blue point. Re-close with /trigger BClose when ready.","color":"blue"}]
