# Test preset: build two rectangular areas without walking them out, then close
# them. Run this as a player with /function capture_the_flag:test.
# Vertices are listed in consistent (convex) order around each rectangle.
data modify storage capture_the_flag:poly blue_verts set value [{x:650,y:-59,z:265},{x:658,y:-59,z:265},{x:658,y:-59,z:376},{x:650,y:-59,z:376}]
data modify storage capture_the_flag:poly red_verts set value [{x:660,y:-59,z:365},{x:670,y:-59,z:365},{x:670,y:-59,z:376},{x:660,y:-59,z:376}]
function capture_the_flag:close_blue_poly
function capture_the_flag:close_red_poly
