# Broadcast that the match is starting.
scoreboard players set game_started ctf 1
tellraw @a [{"text":"Capture The Flag has started!","color":"gold","bold":true},{"text":" Good luck!","color":"green"}]
