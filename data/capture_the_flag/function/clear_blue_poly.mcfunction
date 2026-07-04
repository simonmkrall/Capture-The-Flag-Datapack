# Discard all Blue vertices and start the area over.
data modify storage capture_the_flag:poly blue_verts set value []
data modify storage capture_the_flag:poly blue_edges set value []
scoreboard players set blue_closed ctf 0
tellraw @s [{"text":"Cleared the Blue area. Add points again with /trigger BAddPoint.","color":"blue"}]
