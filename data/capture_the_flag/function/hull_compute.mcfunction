# Compute the convex hull of the point list in storage capture_the_flag:hull
# "in" (a list of {x,y,z}) and write the boundary corners, in order, to "out".
# Method: gift wrapping (Jarvis march) — start at a guaranteed corner, then
# repeatedly step to the point that keeps every other point on one side.
# Interior points and points on a straight edge are dropped. Y is carried along
# untouched (it is only used later for drawing).
data modify storage capture_the_flag:hull out set value []

# Pick the starting corner: smallest X, ties broken by smallest Z. An extreme
# point like this is always on the hull.
data modify storage capture_the_flag:hull start set from storage capture_the_flag:hull in[0]
data modify storage capture_the_flag:hull scan set from storage capture_the_flag:hull in
function capture_the_flag:hull_find_start

# Walk around the hull from that corner.
data modify storage capture_the_flag:hull cur set from storage capture_the_flag:hull start
scoreboard players set hiter ctf 0
function capture_the_flag:hull_march
