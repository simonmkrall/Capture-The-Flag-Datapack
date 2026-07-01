# Runs when a Red player captures the Blue flag.
# Award Red one capture point.
scoreboard players add "Red" Points 1

# Keep the sidebar fake-player names colored after the score changes.
scoreboard players display name "Red" Points {"text":"Red","color":"red"}
scoreboard players display name "Blue" Points {"text":"Blue","color":"blue"}

# Copy the current team scores into storage for the chat message.
execute store result storage capture_the_flag:scores red int 1 run scoreboard players get "Red" Points
execute store result storage capture_the_flag:scores blue int 1 run scoreboard players get "Blue" Points

# Give the player their normal helmet back after removing the carried flag.
item replace entity @s armor.head with iron_helmet[unbreakable={}]

# Mark this player as no longer holding the Blue flag.
scoreboard players set @s has_blue_flag 0

# Announce the capture and show both team scores to everyone.
tellraw @a [{"text":"Red team captured the flag! ","color":"red"},{"text":"Red: ","color":"red"},{"nbt":"red","storage":"capture_the_flag:scores","color":"red"},{"text":" | Blue: ","color":"blue"},{"nbt":"blue","storage":"capture_the_flag:scores","color":"blue"}]

# Summon Firework to show score
execute at @s run summon firework_rocket ~ ~1 ~ {LifeTime:15,FireworksItem:{id:firework_rocket,count:1,components:{fireworks:{flight_duration:2,explosions:[{shape:"large_ball",colors:[I;11743532]}]}}}}

# Restore the Blue flag banner at its home marker.
execute at @e[tag=blue_flag_home,limit=1] run setblock ~ ~1 ~ blue_banner

# Remove the flag-carrying tag so future checks treat the capture as finished.
tag @s remove carrying_blue_flag
