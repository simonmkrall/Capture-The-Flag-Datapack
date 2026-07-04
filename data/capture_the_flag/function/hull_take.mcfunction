# Adopt the scanned point (scan[0]) as the current candidate next-corner.
data modify storage capture_the_flag:hull cand set from storage capture_the_flag:hull scan[0]
scoreboard players set hcand_set ctf 1
execute store result score ndx ctf run data get storage capture_the_flag:hull cand.x
execute store result score ndz ctf run data get storage capture_the_flag:hull cand.z
