# Draw the Blue boundary: pick the blue color, then walk the blue edge list.
scoreboard players set draw_color ctf 1
data modify storage capture_the_flag:poly draw set from storage capture_the_flag:poly blue_edges
function capture_the_flag:draw_edges
