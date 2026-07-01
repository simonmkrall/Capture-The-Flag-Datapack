# Runs when the Red carrier dies with the Blue flag.
execute at @e[tag=blue_flag_home,limit=1] run setblock ~ ~1 ~ blue_banner
item replace entity @s armor.head with iron_helmet[unbreakable={}]
scoreboard players set @s has_blue_flag 0
tellraw @a {"text":"Blue Flag Returned!","color":"gold"}
tag @s remove carrying_blue_flag
