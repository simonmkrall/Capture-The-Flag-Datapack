# Test preset: save Blue territory corner 1 to fixed coordinates.
execute store result score blue_corner_1_x ctf run scoreboard players set ctf blue_corner_1_x 650
execute store result score blue_corner_1_y ctf run scoreboard players set ctf blue_corner_1_y -59
execute store result score blue_corner_1_z ctf run scoreboard players set ctf blue_corner_1_z 265
scoreboard players set bounds_set ctf 1
tellraw @s [{"text":"Blue Corner 1 set at ","color":"blue"},{"text":"X:","color":"white"},{"score":{"name":"blue_corner_1_x","objective":"ctf"}},{"text":" Y:","color":"white"},{"score":{"name":"blue_corner_1_y","objective":"ctf"}},{"text":" Z:","color":"white"},{"score":{"name":"blue_corner_1_z","objective":"ctf"}}]

# Test preset: save Blue territory corner 2 to fixed coordinates.
execute store result score blue_corner_2_x ctf run scoreboard players set ctf blue_corner_2_x 658
execute store result score blue_corner_2_y ctf run scoreboard players set ctf blue_corner_2_y -59
execute store result score blue_corner_2_z ctf run scoreboard players set ctf blue_corner_2_z 376
scoreboard players set bounds_set ctf 1
tellraw @s [{"text":"Blue Corner 2 set at ","color":"blue"},{"text":"X:","color":"white"},{"score":{"name":"blue_corner_2_x","objective":"ctf"}},{"text":" Y:","color":"white"},{"score":{"name":"blue_corner_2_y","objective":"ctf"}},{"text":" Z:","color":"white"},{"score":{"name":"blue_corner_2_z","objective":"ctf"}}]

# Test preset: save Red territory corner 1 to fixed coordinates.
execute store result score red_corner_1_x ctf run scoreboard players set ctf red_corner_1_x 660
execute store result score red_corner_1_y ctf run scoreboard players set ctf red_corner_1_y -59
execute store result score red_corner_1_z ctf run scoreboard players set ctf red_corner_1_z 376
scoreboard players set bounds_set ctf 1
tellraw @s [{"text":"Red Corner 1 set at ","color":"red"},{"text":"X:","color":"white"},{"score":{"name":"red_corner_1_x","objective":"ctf"}},{"text":" Y:","color":"white"},{"score":{"name":"red_corner_1_y","objective":"ctf"}},{"text":" Z:","color":"white"},{"score":{"name":"red_corner_1_z","objective":"ctf"}}]

# Test preset: save Red territory corner 2 to fixed coordinates.
execute store result score red_corner_2_x ctf run scoreboard players set ctf red_corner_2_x 670
execute store result score red_corner_2_y ctf run scoreboard players set ctf red_corner_2_y -59
execute store result score red_corner_2_z ctf run scoreboard players set ctf red_corner_2_z 365
scoreboard players set bounds_set ctf 1
tellraw @s [{"text":"Red Corner 2 set at ","color":"red"},{"text":"X:","color":"white"},{"score":{"name":"red_corner_2_x","objective":"ctf"}},{"text":" Y:","color":"white"},{"score":{"name":"red_corner_2_y","objective":"ctf"}},{"text":" Z:","color":"white"},{"score":{"name":"red_corner_2_z","objective":"ctf"}}]
