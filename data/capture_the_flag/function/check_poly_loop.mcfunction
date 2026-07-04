# Recursively consume "loop" (a copy of a team's edge list), computing the 2D
# cross product of each edge against the player position (px, pz). Records
# whether any edge gave a positive result and whether any gave a negative one.
# Shared by check_red and check_blue.
execute unless data storage capture_the_flag:poly loop[0] run return 0

# Load the current edge: start point (ax, az) and direction (dx, dz).
execute store result score ax ctf run data get storage capture_the_flag:poly loop[0].ax
execute store result score az ctf run data get storage capture_the_flag:poly loop[0].az
execute store result score dx ctf run data get storage capture_the_flag:poly loop[0].dx
execute store result score dz ctf run data get storage capture_the_flag:poly loop[0].dz

# cross = dx * (pz - az) - dz * (px - ax)
# Both factors are vertex-relative differences, so the product stays small even
# at large absolute world coordinates.
scoreboard players operation t1 ctf = pz ctf
scoreboard players operation t1 ctf -= az ctf
scoreboard players operation t1 ctf *= dx ctf
scoreboard players operation t2 ctf = px ctf
scoreboard players operation t2 ctf -= ax ctf
scoreboard players operation t2 ctf *= dz ctf
scoreboard players operation t1 ctf -= t2 ctf

# Tally the sign. Zero means exactly on the edge line and counts as neither.
execute if score t1 ctf matches 1.. run scoreboard players set any_pos ctf 1
execute if score t1 ctf matches ..-1 run scoreboard players set any_neg ctf 1

# Drop this edge and recurse.
data remove storage capture_the_flag:poly loop[0]
function capture_the_flag:check_poly_loop
