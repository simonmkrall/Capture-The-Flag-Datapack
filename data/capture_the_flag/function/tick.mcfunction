# Run boundary checks only after the play areas have been configured.
execute if score bounds_set ctf matches 1 run function capture_the_flag:enforce_boundary

# Prevent players from shooting bows while outside their own territory.
execute if score bounds_set ctf matches 1 run function capture_the_flag:block_enemy_territory_arrows

# If a flag carrier dies, return the flag and clear their carried-flag state.
execute as @a[team=Blue,scores={has_red_flag=1}] if score @s health matches 0 run function capture_the_flag:return_red_flag
execute as @a[team=Red,scores={has_blue_flag=1}] if score @s health matches 0 run function capture_the_flag:return_blue_flag

# Restore the normal helmet if a carried flag is no longer active.
execute as @a[team=Blue,scores={has_red_flag=0}] if data entity @s Inventory[{Slot:103b,id:"minecraft:red_banner"}] run item replace entity @s armor.head with iron_helmet[unbreakable={}]
execute as @a[team=Red,scores={has_blue_flag=0}] if data entity @s Inventory[{Slot:103b,id:"minecraft:blue_banner"}] run item replace entity @s armor.head with iron_helmet[unbreakable={}]

# Check for flag pickup, scoring, and carrier glow.
execute if score bounds_set ctf matches 1 run function capture_the_flag:check_flags

# Show carried flags as banners in each carrier's helmet slot.
execute as @a[team=Blue, scores={has_red_flag=1}] run item replace entity @s armor.head with red_banner
execute as @a[team=Red, scores={has_blue_flag=1}] run item replace entity @s armor.head with blue_banner

# Let Red players use /trigger PlaceRedFlag to place or move their flag.
scoreboard players enable @a PlaceRedFlag
execute as @a[scores={PlaceRedFlag=1..},team=Red] at @s run function capture_the_flag:place_red_flag
execute as @a[scores={PlaceRedFlag=1..},team=Red] run scoreboard players set @s PlaceRedFlag 0

# Let one Blue player take the Red flag when no Red-flag carrier exists.
tag @a remove carrying_red_flag
execute unless entity @a[scores={has_red_flag=1}] at @e[tag=red_flag_home,limit=1] as @a[team=Blue,distance=..2.5,limit=1,sort=nearest] if score @s health matches 1.. run function capture_the_flag:red_stolen

# Let Blue players use /trigger PlaceBlueFlag to place or move their flag.
scoreboard players enable @a PlaceBlueFlag
execute as @a[scores={PlaceBlueFlag=1..},team=Blue] at @s run function capture_the_flag:place_blue_flag
execute as @a[scores={PlaceBlueFlag=1..},team=Blue] run scoreboard players set @s PlaceBlueFlag 0

# Let one Red player take the Blue flag when no Blue-flag carrier exists.
tag @a remove carrying_blue_flag
execute unless entity @a[scores={has_blue_flag=1}] at @e[tag=blue_flag_home,limit=1] as @a[team=Red,distance=..2.5,limit=1,sort=nearest] if score @s health matches 1.. run function capture_the_flag:blue_stolen

# Enable and handle the Blue boundary corner triggers.
scoreboard players enable @a BCorner1
execute as @a[scores={BCorner1=1}] run function capture_the_flag:set_blue_corner_1
execute as @a[scores={BCorner1=1}] run scoreboard players set @s BCorner1 0
scoreboard players enable @a BCorner2
execute as @a[scores={BCorner2=1}] run function capture_the_flag:set_blue_corner_2
execute as @a[scores={BCorner2=1}] run scoreboard players set @s BCorner2 0

# Enable and handle the Red boundary corner triggers.
scoreboard players enable @a RCorner1
execute as @a[scores={RCorner1=1}] run function capture_the_flag:set_red_corner_1
execute as @a[scores={RCorner1=1}] run scoreboard players set @s RCorner1 0
scoreboard players enable @a RCorner2
execute as @a[scores={RCorner2=1}] run function capture_the_flag:set_red_corner_2
execute as @a[scores={RCorner2=1}] run scoreboard players set @s RCorner2 0

# Give each player their kit once, or warn them if they already got it.
scoreboard players enable @a Kit
execute as @a[scores={Kit=1},tag=kit_given] run function capture_the_flag:kit_already_given
execute as @a[scores={Kit=1},tag=!kit_given] run function capture_the_flag:kit
execute as @a[scores={Kit=1}] run scoreboard players set @s Kit 0

# Handle team selection triggers.
scoreboard players enable @a RedTeam
execute as @a[scores={RedTeam=1}] run function capture_the_flag:red_join
execute as @a[scores={RedTeam=1}] run scoreboard players set @s RedTeam 0
scoreboard players enable @a BlueTeam
execute as @a[scores={BlueTeam=1}] run function capture_the_flag:blue_join
execute as @a[scores={BlueTeam=1}] run scoreboard players set @s BlueTeam 0

# Let players leave their current team.
scoreboard players enable @a LeaveTeam
execute as @a[scores={LeaveTeam=1}] run function capture_the_flag:team_leave
execute as @a[scores={LeaveTeam=1}] run scoreboard players set @s LeaveTeam 0

# Remove glowing from players who are not currently marked as carrying either flag.
execute as @a[scores={has_red_flag=0,has_blue_flag=0}] run effect clear @s glowing

# If the disable trigger is activated, run the disable function to end the game.
scoreboard players enable @a Disable_Game
execute as @a[scores={Disable_Game=1}] run function capture_the_flag:disable
execute as @a[scores={Disable_Game=1}] run scoreboard players set @s Disable_Game 0

scoreboard players enable @a Info
execute as @a[scores={Info=1}] run function capture_the_flag:info
execute as @a[scores={Info=1}] run scoreboard players set @s Info 0