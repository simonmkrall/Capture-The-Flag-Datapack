# Finish the Blue area. The corners you walked are reduced to their convex hull,
# so the enforced (and drawn) boundary is always convex: any inward dent is
# filled in, and the order you dropped points in does not matter. Needs at least
# 3 points that actually enclose an area.
execute unless data storage capture_the_flag:poly blue_verts[2] run return run tellraw @s [{"text":"The Blue area needs at least 3 points before it can be closed.","color":"blue"}]

# Convex hull of the walked points -> blue_hull.
data modify storage capture_the_flag:hull in set from storage capture_the_flag:poly blue_verts
function capture_the_flag:hull_compute
data modify storage capture_the_flag:poly blue_hull set from storage capture_the_flag:hull out

# Reject a degenerate result (all points in a line make no enclosed area).
execute store result score hulln ctf run data get storage capture_the_flag:poly blue_hull
execute if score hulln ctf matches ..2 run return run tellraw @s [{"text":"Those points are in a line and don't enclose an area. Spread them out and try again.","color":"blue"}]

# Turn the hull ring into edge vectors (seeded so the wrap-around edge is built).
data modify storage capture_the_flag:poly prev set from storage capture_the_flag:poly blue_hull[-1]
data modify storage capture_the_flag:poly work set from storage capture_the_flag:poly blue_hull
data modify storage capture_the_flag:poly build_edges set value []
function capture_the_flag:build_blue_edges
data modify storage capture_the_flag:poly blue_edges set from storage capture_the_flag:poly build_edges

# Enable boundary checks for Blue, and globally now that an area exists.
scoreboard players set blue_closed ctf 1
scoreboard players set bounds_set ctf 1
tellraw @s [{"text":"Blue area closed. Boundary is now active.","color":"blue"}]

# If the hull used fewer corners than were walked, let the player know some
# points were absorbed (interior, on an edge, or filling a concave dent).
execute store result score rawn ctf run data get storage capture_the_flag:poly blue_verts
execute if score hulln ctf < rawn ctf run tellraw @s [{"text":"(Rounded to a convex shape using ","color":"gray"},{"score":{"name":"hulln","objective":"ctf"}},{"text":" of ","color":"gray"},{"score":{"name":"rawn","objective":"ctf"}},{"text":" points.)","color":"gray"}]
