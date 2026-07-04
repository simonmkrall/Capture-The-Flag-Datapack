# Draw the Red boundary: pick the red color, then walk the red edge list.
scoreboard players set draw_color ctf 0
data modify storage capture_the_flag:poly draw set from storage capture_the_flag:poly red_edges
function capture_the_flag:draw_edges
