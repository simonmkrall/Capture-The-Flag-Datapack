# Append the player's current X/Z as the next vertex of the Red area.
# Vertices are stored in order; walk your border one way (all clockwise or
# all counter-clockwise) and add a point at each corner.
data modify storage capture_the_flag:poly v set value {x:0,y:0,z:0}
execute store result storage capture_the_flag:poly v.x int 1 run data get entity @s Pos[0] 1
execute store result storage capture_the_flag:poly v.y int 1 run data get entity @s Pos[1] 1
execute store result storage capture_the_flag:poly v.z int 1 run data get entity @s Pos[2] 1
data modify storage capture_the_flag:poly red_verts append from storage capture_the_flag:poly v

# Adding a point invalidates any previously closed area; re-close when done.
scoreboard players set red_closed ctf 0

tellraw @s [{"text":"Red point added at ","color":"red"},{"text":"X:","color":"white"},{"nbt":"v.x","storage":"capture_the_flag:poly"},{"text":" Z:","color":"white"},{"nbt":"v.z","storage":"capture_the_flag:poly"},{"text":". Run /trigger RClose when the loop is complete.","color":"gray"}]
