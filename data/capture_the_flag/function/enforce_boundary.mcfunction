# Calculate Red territory bounds from the two saved corner positions.
scoreboard players operation red_min_x ctf = red_corner_1_x ctf
scoreboard players operation red_min_x ctf < red_corner_2_x ctf
scoreboard players operation red_max_x ctf = red_corner_1_x ctf
scoreboard players operation red_max_x ctf > red_corner_2_x ctf
scoreboard players operation red_min_z ctf = red_corner_1_z ctf
scoreboard players operation red_min_z ctf < red_corner_2_z ctf
scoreboard players operation red_max_z ctf = red_corner_1_z ctf
scoreboard players operation red_max_z ctf > red_corner_2_z ctf

# Calculate Blue territory bounds from the two saved corner positions.
scoreboard players operation blue_min_x ctf = blue_corner_1_x ctf
scoreboard players operation blue_min_x ctf < blue_corner_2_x ctf
scoreboard players operation blue_max_x ctf = blue_corner_1_x ctf
scoreboard players operation blue_max_x ctf > blue_corner_2_x ctf
scoreboard players operation blue_min_z ctf = blue_corner_1_z ctf
scoreboard players operation blue_min_z ctf < blue_corner_2_z ctf
scoreboard players operation blue_max_z ctf = blue_corner_1_z ctf
scoreboard players operation blue_max_z ctf > blue_corner_2_z ctf

# Store each player's current integer position for boundary comparisons.
execute as @a store result score @s player_x run data get entity @s Pos[0] 1
execute as @a store result score @s player_y run data get entity @s Pos[1] 1
execute as @a store result score @s player_z run data get entity @s Pos[2] 1

# Assume everyone is inside until a boundary check proves otherwise.
scoreboard players set @a inside_boundary 1

# Mark Red players outside Red territory.
execute as @a[team=Red] if score @s player_x < red_min_x ctf run scoreboard players set @s inside_boundary 0
execute as @a[team=Red] if score @s player_x > red_max_x ctf run scoreboard players set @s inside_boundary 0
execute as @a[team=Red] if score @s player_z < red_min_z ctf run scoreboard players set @s inside_boundary 0
execute as @a[team=Red] if score @s player_z > red_max_z ctf run scoreboard players set @s inside_boundary 0

# Mark Blue players outside Blue territory.
execute as @a[team=Blue] if score @s player_x < blue_min_x ctf run scoreboard players set @s inside_boundary 0
execute as @a[team=Blue] if score @s player_x > blue_max_x ctf run scoreboard players set @s inside_boundary 0
execute as @a[team=Blue] if score @s player_z < blue_min_z ctf run scoreboard players set @s inside_boundary 0
execute as @a[team=Blue] if score @s player_z > blue_max_z ctf run scoreboard players set @s inside_boundary 0

# Punish players outside their territory, and clear effects when they return.
execute as @a if score @s inside_boundary matches 0 run effect give @s minecraft:weakness infinite 255 true
execute as @a if score @s inside_boundary matches 1 run effect clear @s
