# Final guard before scoring: Blue must be back inside Blue territory.
execute if score @s inside_boundary matches 1 run function capture_the_flag:blue_scores
