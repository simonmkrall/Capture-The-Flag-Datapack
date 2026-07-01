# Runs when the Blue carrier dies with the Red flag.
execute at @e[tag=red_flag_home,limit=1] run setblock ~ ~1 ~ red_banner
item replace entity @s armor.head with iron_helmet[unbreakable={}]
scoreboard players set @s has_red_flag 0
tellraw @a {"text":"Red Flag Returned!","color":"gold"}
tag @s remove carrying_red_flag
