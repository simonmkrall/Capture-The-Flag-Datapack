# Final guard before scoring: Red must be back inside Red territory.
execute if score @s inside_boundary matches 1 run function capture_the_flag:red_scores
