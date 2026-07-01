# Mark this Red player as carrying the Blue flag.
tag @s add carrying_blue_flag

# Remove the Blue flag banner from its home position.
execute at @e[tag=blue_flag_home,limit=1] run setblock ~ ~1 ~ air

# Mark this player as carrying the Blue flag.
scoreboard players set @s has_blue_flag 1

# Announce that the Blue flag was taken.
tellraw @a {"text":"Blue Flag Taken!","color":"gold"}
