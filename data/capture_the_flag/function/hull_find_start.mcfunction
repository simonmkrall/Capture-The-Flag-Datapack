# Consume "scan" (a copy of the input), keeping the smallest-X (then smallest-Z)
# point in "start". That point is guaranteed to be a hull corner.
execute unless data storage capture_the_flag:hull scan[0] run return 0
execute store result score tpx ctf run data get storage capture_the_flag:hull scan[0].x
execute store result score tpz ctf run data get storage capture_the_flag:hull scan[0].z
execute store result score hstartx ctf run data get storage capture_the_flag:hull start.x
execute store result score hstartz ctf run data get storage capture_the_flag:hull start.z
execute if score tpx ctf < hstartx ctf run data modify storage capture_the_flag:hull start set from storage capture_the_flag:hull scan[0]
execute if score tpx ctf = hstartx ctf if score tpz ctf < hstartz ctf run data modify storage capture_the_flag:hull start set from storage capture_the_flag:hull scan[0]
data remove storage capture_the_flag:hull scan[0]
function capture_the_flag:hull_find_start
