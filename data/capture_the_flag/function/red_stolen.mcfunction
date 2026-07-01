# Mark this Blue player as carrying the Red flag.
tag @s add carrying_red_flag

# Remove the Red flag banner from its home position.
execute at @e[tag=red_flag_home,limit=1] run setblock ~ ~1 ~ air

# Mark this player as carrying the Red flag.
scoreboard players set @s has_red_flag 1

# Announce that the Red flag was taken.
tellraw @a {"text":"Red Flag Taken!","color":"gold"}
