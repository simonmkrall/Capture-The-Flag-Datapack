# If a Red player has the Blue banner in inventory, mark them as carrying it.
execute as @a[team=Red] unless score @s has_blue_flag matches 1 if data entity @s Inventory[{Slot:103b,id:"minecraft:blue_banner"}] run tellraw @a {"text":"Blue Flag Taken!","color":"gold"}
execute as @a[team=Red] unless score @s has_blue_flag matches 1 if data entity @s Inventory[{Slot:103b,id:"minecraft:blue_banner"}] run scoreboard players set @s has_blue_flag 1
execute as @a[team=Red] if data entity @s Inventory[{Slot:103b,id:"minecraft:blue_banner"}] run clear @s blue_banner

# If a Blue player has the Red banner in inventory, mark them as carrying it.
execute as @a[team=Blue] unless score @s has_red_flag matches 1 if data entity @s Inventory[{Slot:103b,id:"minecraft:red_banner"}] run tellraw @a {"text":"Red Flag Taken!","color":"gold"}
execute as @a[team=Blue] unless score @s has_red_flag matches 1 if data entity @s Inventory[{Slot:103b,id:"minecraft:red_banner"}] run scoreboard players set @s has_red_flag 1
execute as @a[team=Blue] if data entity @s Inventory[{Slot:103b,id:"minecraft:red_banner"}] run clear @s red_banner

# Score for Red when a Blue-flag carrier is inside Red territory.
execute as @a[team=Red] if score @s has_blue_flag matches 1 if score @s inside_boundary matches 1 run function capture_the_flag:red_has_blue_flag

# Score for Blue when a Red-flag carrier is inside Blue territory.
execute as @a[team=Blue] if score @s has_red_flag matches 1 if score @s inside_boundary matches 1 run function capture_the_flag:blue_has_red_flag

# Make flag carriers glow so both teams can track them.
execute as @a if score @s has_blue_flag matches 1 run effect give @s glowing infinite 1 true
execute as @a if score @s has_red_flag matches 1 run effect give @s glowing infinite 1 true
