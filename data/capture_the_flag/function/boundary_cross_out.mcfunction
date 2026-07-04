# The player just left their territory: warning cue (run as @s at @s).
# Low double note plus a burst of flame and smoke around them.
playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.6
playsound minecraft:entity.villager.no master @s ~ ~ ~ 0.7 1
particle minecraft:flame ~ ~1 ~ 0.4 0.6 0.4 0.02 40 force @s
particle minecraft:large_smoke ~ ~1 ~ 0.4 0.6 0.4 0.01 25 force @s
