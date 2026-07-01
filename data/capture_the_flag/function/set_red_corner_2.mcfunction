# Set Red team corner 2 at player's current position
# Save this player's current X/Y/Z into the Red corner 2 scores.
execute store result score red_corner_2_x ctf run data get entity @s Pos[0] 1
execute store result score red_corner_2_y ctf run data get entity @s Pos[1] 1
execute store result score red_corner_2_z ctf run data get entity @s Pos[2] 1

# Enable boundary checks now that at least one corner has been set.
scoreboard players set bounds_set ctf 1

# Confirm the saved coordinates to the player.
tellraw @s [{"text":"Red Corner 2 set at ","color":"red"},{"text":"X:","color":"white"},{"score":{"name":"red_corner_2_x","objective":"ctf"}},{"text":" Y:","color":"white"},{"score":{"name":"red_corner_2_y","objective":"ctf"}},{"text":" Z:","color":"white"},{"score":{"name":"red_corner_2_z","objective":"ctf"}}]
