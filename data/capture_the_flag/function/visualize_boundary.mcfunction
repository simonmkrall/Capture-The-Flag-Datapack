# Draw both teams' closed boundaries as lines of colored particles.
# Runs every tick while the ShowBounds toggle is on (see tick.mcfunction).
# Red edges are drawn in red, Blue edges in blue; open (unclosed) areas are
# skipped since they have no edges yet.
execute if score red_closed ctf matches 1 run function capture_the_flag:draw_red_bounds
execute if score blue_closed ctf matches 1 run function capture_the_flag:draw_blue_bounds
