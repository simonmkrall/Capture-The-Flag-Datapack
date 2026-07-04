# A player just changed inside/outside state this tick (only called while the
# ShowBounds overlay is on). Play the matching cue at their position.
execute if score @s inside_boundary matches 0 run function capture_the_flag:boundary_cross_out
execute if score @s inside_boundary matches 1 run function capture_the_flag:boundary_cross_in
