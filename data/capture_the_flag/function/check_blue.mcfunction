# Point-in-convex-polygon test for the current Blue player (run as @s).
# Loads this player's X/Z and the Blue edge list, then tallies which side of
# each edge the player is on. Inside a convex polygon means every edge reports
# the same side, so seeing both a positive and a negative cross => outside.
scoreboard players set any_pos ctf 0
scoreboard players set any_neg ctf 0
execute store result score px ctf run data get entity @s Pos[0] 1
execute store result score pz ctf run data get entity @s Pos[2] 1
data modify storage capture_the_flag:poly loop set from storage capture_the_flag:poly blue_edges
function capture_the_flag:check_poly_loop

# Default (set in enforce_boundary) is inside=1; only mark outside on mixed signs.
execute if score any_pos ctf matches 1 if score any_neg ctf matches 1 run scoreboard players set @s inside_boundary 0
