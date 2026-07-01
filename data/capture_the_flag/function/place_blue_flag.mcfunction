# Remove any old Blue flag home markers before placing a new flag.
kill @e[tag=blue_flag_home]

# Place the Blue flag banner at the player's current position.
setblock ~ ~ ~ blue_banner strict

# Store the flag home marker one block below the banner.
summon marker ~ ~-1 ~ {Tags:["blue_flag_home"]}
