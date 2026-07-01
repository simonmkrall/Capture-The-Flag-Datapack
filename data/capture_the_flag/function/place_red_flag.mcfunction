# Remove any old Red flag home markers before placing a new flag.
kill @e[tag=red_flag_home]

# Place the Red flag banner at the player's current position.
setblock ~ ~ ~ red_banner strict

# Store the flag home marker one block below the banner.
summon marker ~ ~-1 ~ {Tags:["red_flag_home"]}
