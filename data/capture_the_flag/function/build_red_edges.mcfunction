# Recursively consume "work" (a copy of the vertex list), emitting one edge per
# vertex. Each edge stores its start point (ax, az) and its direction vector
# (dx, dz) = current - prev. Stops when "work" is empty.
execute unless data storage capture_the_flag:poly work[0] run return 0

# Pull the previous vertex and the current vertex into scratch scores.
# Y is only used to draw the boundary; the inside/outside test ignores it.
execute store result score ax ctf run data get storage capture_the_flag:poly prev.x
execute store result score ay ctf run data get storage capture_the_flag:poly prev.y
execute store result score az ctf run data get storage capture_the_flag:poly prev.z
execute store result score cx ctf run data get storage capture_the_flag:poly work[0].x
execute store result score cy ctf run data get storage capture_the_flag:poly work[0].y
execute store result score cz ctf run data get storage capture_the_flag:poly work[0].z

# Edge direction = current - prev.
scoreboard players operation dx ctf = cx ctf
scoreboard players operation dx ctf -= ax ctf
scoreboard players operation dy ctf = cy ctf
scoreboard players operation dy ctf -= ay ctf
scoreboard players operation dz ctf = cz ctf
scoreboard players operation dz ctf -= az ctf

# Write the edge {ax, ay, az, dx, dy, dz} and append it.
data modify storage capture_the_flag:poly e set value {ax:0,ay:0,az:0,dx:0,dy:0,dz:0}
execute store result storage capture_the_flag:poly e.ax int 1 run scoreboard players get ax ctf
execute store result storage capture_the_flag:poly e.ay int 1 run scoreboard players get ay ctf
execute store result storage capture_the_flag:poly e.az int 1 run scoreboard players get az ctf
execute store result storage capture_the_flag:poly e.dx int 1 run scoreboard players get dx ctf
execute store result storage capture_the_flag:poly e.dy int 1 run scoreboard players get dy ctf
execute store result storage capture_the_flag:poly e.dz int 1 run scoreboard players get dz ctf
data modify storage capture_the_flag:poly build_edges append from storage capture_the_flag:poly e

# Advance: this vertex becomes "prev", drop it from "work", and recurse.
data modify storage capture_the_flag:poly prev set from storage capture_the_flag:poly work[0]
data remove storage capture_the_flag:poly work[0]
function capture_the_flag:build_red_edges
