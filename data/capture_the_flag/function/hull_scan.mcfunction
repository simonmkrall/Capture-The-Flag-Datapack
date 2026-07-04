# Walk the copied point list, considering every point except the current corner
# (a point equal to cur in both X and Z is the current corner and is skipped).
execute unless data storage capture_the_flag:hull scan[0] run return 0
execute store result score tpx ctf run data get storage capture_the_flag:hull scan[0].x
execute store result score tpz ctf run data get storage capture_the_flag:hull scan[0].z
execute unless score tpx ctf = hcx ctf run function capture_the_flag:hull_consider
execute if score tpx ctf = hcx ctf unless score tpz ctf = hcz ctf run function capture_the_flag:hull_consider
data remove storage capture_the_flag:hull scan[0]
function capture_the_flag:hull_scan
