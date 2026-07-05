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

# Enable and handle the Blue boundary polygon triggers.
scoreboard players enable @a BAddPoint
execute as @a[scores={BAddPoint=1}] run function capture_the_flag:add_blue_point
execute as @a[scores={BAddPoint=1}] run scoreboard players set @s BAddPoint 0
scoreboard players enable @a BClose
execute as @a[scores={BClose=1}] run function capture_the_flag:close_blue_poly
execute as @a[scores={BClose=1}] run scoreboard players set @s BClose 0
scoreboard players enable @a BUndo
execute as @a[scores={BUndo=1}] run function capture_the_flag:undo_blue_point
execute as @a[scores={BUndo=1}] run scoreboard players set @s BUndo 0
scoreboard players enable @a BClear
execute as @a[scores={BClear=1}] run function capture_the_flag:clear_blue_poly
execute as @a[scores={BClear=1}] run scoreboard players set @s BClear 0

# Enable and handle the Red boundary polygon triggers.
scoreboard players enable @a RAddPoint
execute as @a[scores={RAddPoint=1}] run function capture_the_flag:add_red_point
execute as @a[scores={RAddPoint=1}] run scoreboard players set @s RAddPoint 0
scoreboard players enable @a RClose
execute as @a[scores={RClose=1}] run function capture_the_flag:close_red_poly
execute as @a[scores={RClose=1}] run scoreboard players set @s RClose 0
scoreboard players enable @a RUndo
execute as @a[scores={RUndo=1}] run function capture_the_flag:undo_red_point
execute as @a[scores={RUndo=1}] run scoreboard players set @s RUndo 0
scoreboard players enable @a RClear
execute as @a[scores={RClear=1}] run function capture_the_flag:clear_red_poly
execute as @a[scores={RClear=1}] run scoreboard players set @s RClear 0

# Toggle the boundary particle overlay, and redraw it each tick while it is on.
scoreboard players enable @a ShowBounds
execute as @a[scores={ShowBounds=1}] run function capture_the_flag:toggle_show_bounds
execute as @a[scores={ShowBounds=1}] run scoreboard players set @s ShowBounds 0
execute if score show_bounds ctf matches 1 run function capture_the_flag:visualize_boundary

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

# Let anyone announce the match start.
scoreboard players enable @a Start_Game
execute as @a[scores={Start_Game=1}] run function capture_the_flag:start_game
execute as @a[scores={Start_Game=1}] run scoreboard players set @s Start_Game 0

# Remove glowing from players who are not currently marked as carrying either flag.
execute as @a[scores={has_red_flag=0,has_blue_flag=0}] run effect clear @s glowing

# If the disable trigger is activated, run the disable function to end the game.
scoreboard players enable @a Disable_Game
execute as @a[scores={Disable_Game=1}] run function capture_the_flag:disable
execute as @a[scores={Disable_Game=1}] run scoreboard players set @s Disable_Game 0

scoreboard players enable @a Info
execute as @a[scores={Info=1}] run function capture_the_flag:info
execute as @a[scores={Info=1}] run scoreboard players set @s Info 0
