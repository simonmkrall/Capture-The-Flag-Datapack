# Remove this player from whichever team they are currently on.
team leave @s
scoreboard players set @s has_red_flag 0
scoreboard players set @s has_blue_flag 0
effect clear @s glowing
