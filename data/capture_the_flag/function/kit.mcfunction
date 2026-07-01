# Clear the player's inventory before giving the standard kit.
clear @s

# Give weapons, ammo, and food.
give @s iron_sword[unbreakable={}] 1
give @s bow[unbreakable={},enchantments={"minecraft:power":2}] 1
give @s arrow 160
give @s cooked_beef 128

# Equip unbreakable armor.
item replace entity @s armor.head with iron_helmet[unbreakable={}]
item replace entity @s armor.chest with iron_chestplate[unbreakable={}]
item replace entity @s armor.legs with iron_leggings[unbreakable={}]
item replace entity @s armor.feet with iron_boots[unbreakable={}]

# Put the shield in the offhand.
item replace entity @s weapon.offhand with shield[unbreakable={}]

# Remember that this player already received their kit.
tag @s add kit_given
