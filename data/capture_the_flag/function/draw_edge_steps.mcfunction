# Place one particle at fraction i/steps along the current edge, then advance i.
# point = A + direction * i / steps  (computed per axis with integer math)
scoreboard players operation tmp ctf = dx ctf
scoreboard players operation tmp ctf *= i ctf
scoreboard players operation tmp ctf /= steps ctf
scoreboard players operation cx ctf = ax ctf
scoreboard players operation cx ctf += tmp ctf

scoreboard players operation tmp ctf = dy ctf
scoreboard players operation tmp ctf *= i ctf
scoreboard players operation tmp ctf /= steps ctf
scoreboard players operation cy ctf = ay ctf
scoreboard players operation cy ctf += tmp ctf

scoreboard players operation tmp ctf = dz ctf
scoreboard players operation tmp ctf *= i ctf
scoreboard players operation tmp ctf /= steps ctf
scoreboard players operation cz ctf = az ctf
scoreboard players operation cz ctf += tmp ctf

# Hand the coordinates to a macro so they can be dropped into /particle
# (which needs literal numbers, not scores).
execute store result storage capture_the_flag:draw cx int 1 run scoreboard players get cx ctf
execute store result storage capture_the_flag:draw cy int 1 run scoreboard players get cy ctf
execute store result storage capture_the_flag:draw cz int 1 run scoreboard players get cz ctf
execute if score draw_color ctf matches 0 run function capture_the_flag:draw_particle_red with storage capture_the_flag:draw
execute if score draw_color ctf matches 1 run function capture_the_flag:draw_particle_blue with storage capture_the_flag:draw

# Advance to the next point; stop once we pass the end of the edge.
scoreboard players add i ctf 1
execute if score i ctf <= steps ctf run function capture_the_flag:draw_edge_steps
