# Recursively consume "draw" (a copy of a team's edge list), drawing a line of
# particles along each edge. Stops when "draw" is empty.
execute unless data storage capture_the_flag:poly draw[0] run return 0

# Load this edge: start point (ax, ay, az) and direction (dx, dy, dz).
execute store result score ax ctf run data get storage capture_the_flag:poly draw[0].ax
execute store result score ay ctf run data get storage capture_the_flag:poly draw[0].ay
execute store result score az ctf run data get storage capture_the_flag:poly draw[0].az
execute store result score dx ctf run data get storage capture_the_flag:poly draw[0].dx
execute store result score dy ctf run data get storage capture_the_flag:poly draw[0].dy
execute store result score dz ctf run data get storage capture_the_flag:poly draw[0].dz

# Choose how many particles to place: roughly one per block along the longer of
# the X or Z spans, so spacing stays even. Uses abs(dx) and abs(dz) via neg1.
scoreboard players operation steps ctf = dx ctf
execute if score steps ctf matches ..-1 run scoreboard players operation steps ctf *= neg1 ctf
scoreboard players operation adz ctf = dz ctf
execute if score adz ctf matches ..-1 run scoreboard players operation adz ctf *= neg1 ctf
scoreboard players operation steps ctf > adz ctf

# Clamp to at least 1 (avoid divide-by-zero) and cap the cost per edge.
execute if score steps ctf matches ..0 run scoreboard players set steps ctf 1
execute if score steps ctf matches 49.. run scoreboard players set steps ctf 48

# Walk i from 0 to steps, placing a particle at each fraction along the edge.
scoreboard players set i ctf 0
function capture_the_flag:draw_edge_steps

# Drop this edge and move on.
data remove storage capture_the_flag:poly draw[0]
function capture_the_flag:draw_edges
