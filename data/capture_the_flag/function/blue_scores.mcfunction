# Runs when a Blue player captures the Red flag.
# Award Blue one capture point.
scoreboard players add "Blue" Points 1

# Keep the sidebar fake-player names colored after the score changes.
scoreboard players display name "Red" Points {"text":"Red","color":"red"}
scoreboard players display name "Blue" Points {"text":"Blue","color":"blue"}

# Copy the current team scores into storage for the chat message.
execute store result storage capture_the_flag:scores red int 1 run scoreboard players get "Red" Points
execute store result storage capture_the_flag:scores blue int 1 run scoreboard players get "Blue" Points

# Give the player their normal helmet back after removing the carried flag.
item replace entity @s armor.head with iron_helmet[unbreakable={}]

# Mark this player as no longer holding the Red flag.
scoreboard players set @s has_red_flag 0

# Announce the capture and show both team scores to everyone.
tellraw @a [{"text":"Blue team captured the flag! ","color":"blue"},{"text":"Red: ","color":"red"},{"nbt":"red","storage":"capture_the_flag:scores","color":"red"},{"text":" | Blue: ","color":"blue"},{"nbt":"blue","storage":"capture_the_flag:scores","color":"blue"}]

# Summon Firework to show score
execute at @s run summon firework_rocket ~ ~1 ~ {LifeTime:15,FireworksItem:{id:firework_rocket,count:1,components:{fireworks:{flight_duration:2,explosions:[{shape:"large_ball",colors:[I;255]}]}}}}

# Restore the Red flag banner at its home marker.
execute at @e[tag=red_flag_home,limit=1] run setblock ~ ~1 ~ red_banner

# Remove the flag-carrying tag so future checks treat the capture as finished.
tag @s remove carrying_red_flag
