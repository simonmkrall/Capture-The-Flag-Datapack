# Discard all Red vertices and start the area over.
data modify storage capture_the_flag:poly red_verts set value []
data modify storage capture_the_flag:poly red_edges set value []
scoreboard players set red_closed ctf 0
tellraw @s [{"text":"Cleared the Red area. Add points again with /trigger RAddPoint.","color":"red"}]
