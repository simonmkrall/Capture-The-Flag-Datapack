# Replace the candidate with the scanned point if the scanned point lies to the
# RIGHT of the line cur -> candidate (i.e. the candidate wasn't extreme enough).
# cross = (candx - curx) * (pz - curz) - (candz - curz) * (px - curx)
#   cur = (hcx, hcz), candidate = (ndx, ndz), scanned point = (tpx, tpz)
scoreboard players operation e1 ctf = ndx ctf
scoreboard players operation e1 ctf -= hcx ctf
scoreboard players operation e2 ctf = tpz ctf
scoreboard players operation e2 ctf -= hcz ctf
scoreboard players operation e1 ctf *= e2 ctf
scoreboard players operation e3 ctf = ndz ctf
scoreboard players operation e3 ctf -= hcz ctf
scoreboard players operation e4 ctf = tpx ctf
scoreboard players operation e4 ctf -= hcx ctf
scoreboard players operation e3 ctf *= e4 ctf
scoreboard players operation e1 ctf -= e3 ctf

# Negative cross => scanned point is more clockwise => it becomes the candidate.
execute if score e1 ctf matches ..-1 run function capture_the_flag:hull_take
