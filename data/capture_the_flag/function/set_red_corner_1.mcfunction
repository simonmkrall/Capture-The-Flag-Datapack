# Set Red team corner 1 at player's current position
# Save this player's current X/Y/Z into the Red corner 1 scores.
execute store result score red_corner_1_x ctf run data get entity @s Pos[0] 1
execute store result score red_corner_1_y ctf run data get entity @s Pos[1] 1
execute store result score red_corner_1_z ctf run data get entity @s Pos[2] 1

# Enable boundary checks now that at least one corner has been set.
scoreboard players set bounds_set ctf 1

# Confirm the saved coordinates to the player.
tellraw @s [{"text":"Red Corner 1 set at ","color":"red"},{"text":"X:","color":"white"},{"score":{"name":"red_corner_1_x","objective":"ctf"}},{"text":" Y:","color":"white"},{"score":{"name":"red_corner_1_y","objective":"ctf"}},{"text":" Z:","color":"white"},{"score":{"name":"red_corner_1_z","objective":"ctf"}}]