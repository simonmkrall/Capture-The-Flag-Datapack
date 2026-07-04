# Finish the Blue area: turn the ordered vertex ring into edge vectors that
# the per-tick boundary check consumes. Requires at least 3 points, and the
# shape must be convex (the walk-clockwise setup produces this naturally).
execute unless data storage capture_the_flag:poly blue_verts[2] run return run tellraw @s [{"text":"The Blue area needs at least 3 points before it can be closed.","color":"blue"}]

# Seed "prev" with the last vertex so the wrap-around edge (last -> first) is
# included, then build one edge per vertex in order.
data modify storage capture_the_flag:poly prev set from storage capture_the_flag:poly blue_verts[-1]
data modify storage capture_the_flag:poly work set from storage capture_the_flag:poly blue_verts
data modify storage capture_the_flag:poly build_edges set value []
function capture_the_flag:build_blue_edges
data modify storage capture_the_flag:poly blue_edges set from storage capture_the_flag:poly build_edges

# Enable boundary checks for Blue, and globally now that an area exists.
scoreboard players set blue_closed ctf 1
scoreboard players set bounds_set ctf 1
tellraw @s [{"text":"Blue area closed. Boundary is now active.","color":"blue"}]
