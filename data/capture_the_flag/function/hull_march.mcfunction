# One step of the march: record the current corner, then find the next one.
data modify storage capture_the_flag:hull out append from storage capture_the_flag:hull cur
execute store result score hcx ctf run data get storage capture_the_flag:hull cur.x
execute store result score hcz ctf run data get storage capture_the_flag:hull cur.z

# Scan every point and keep the one that is "most clockwise" from cur: the one
# with no other point to its right. That point is the next hull corner.
scoreboard players set hcand_set ctf 0
data modify storage capture_the_flag:hull scan set from storage capture_the_flag:hull in
function capture_the_flag:hull_scan

# Advance to the chosen point.
data modify storage capture_the_flag:hull cur set from storage capture_the_flag:hull cand
execute store result score ndx ctf run data get storage capture_the_flag:hull cand.x
execute store result score ndz ctf run data get storage capture_the_flag:hull cand.z
execute store result score hstartx ctf run data get storage capture_the_flag:hull start.x
execute store result score hstartz ctf run data get storage capture_the_flag:hull start.z

# Stop when we loop back to the start corner. The iteration cap is a safety net
# against pathological input (e.g. many identical points).
scoreboard players add hiter ctf 1
execute if score hiter ctf matches 64.. run return 0
execute if score ndx ctf = hstartx ctf if score ndz ctf = hstartz ctf run return 0
function capture_the_flag:hull_march
