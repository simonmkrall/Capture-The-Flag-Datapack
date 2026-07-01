# Main storage objective for shared datapack values.
scoreboard objectives add ctf dummy

# Boundary and player-position objectives.
scoreboard objectives add bounds_set dummy
scoreboard objectives add inside_boundary dummy
scoreboard objectives add red_corner_1_x dummy
scoreboard objectives add red_corner_1_y dummy
scoreboard objectives add red_corner_1_z dummy
scoreboard objectives add red_corner_2_x dummy
scoreboard objectives add red_corner_2_y dummy
scoreboard objectives add red_corner_2_z dummy
scoreboard objectives add blue_corner_1_x dummy
scoreboard objectives add blue_corner_1_y dummy
scoreboard objectives add blue_corner_1_z dummy
scoreboard objectives add blue_corner_2_x dummy
scoreboard objectives add blue_corner_2_y dummy
scoreboard objectives add blue_corner_2_z dummy
scoreboard objectives add player_x dummy
scoreboard objectives add player_y dummy
scoreboard objectives add player_z dummy

# Cached minimum and maximum boundary coordinates for both team areas.
scoreboard objectives add red_min_x dummy
scoreboard objectives add red_max_x dummy
scoreboard objectives add red_min_y dummy
scoreboard objectives add red_max_y dummy
scoreboard objectives add red_min_z dummy
scoreboard objectives add red_max_z dummy
scoreboard objectives add blue_min_x dummy
scoreboard objectives add blue_max_x dummy
scoreboard objectives add blue_min_y dummy
scoreboard objectives add blue_max_y dummy
scoreboard objectives add blue_min_z dummy
scoreboard objectives add blue_max_z dummy

# Per-player flag-carrying state.
scoreboard objectives add has_red_flag dummy
scoreboard objectives add has_blue_flag dummy
scoreboard objectives add bow_used minecraft.used:minecraft.bow

# Trigger objectives players use as clickable commands.
scoreboard objectives add PlaceRedFlag trigger
scoreboard objectives add PlaceBlueFlag trigger
scoreboard objectives add BCorner1 trigger
scoreboard objectives add BCorner2 trigger
scoreboard objectives add RCorner1 trigger
scoreboard objectives add RCorner2 trigger
scoreboard objectives add Kit trigger
scoreboard objectives add RedTeam trigger
scoreboard objectives add BlueTeam trigger
scoreboard objectives add LeaveTeam trigger

# Visible team score objective.
scoreboard objectives add Points dummy

# Disable score objective
scoreboard objectives add Disable_Game trigger

# Show info text objective
scoreboard objectives add Info trigger

# Reset stored corner coordinates.
scoreboard players set red_corner_1_x ctf 0
scoreboard players set red_corner_1_y ctf 0
scoreboard players set red_corner_1_z ctf 0
scoreboard players set red_corner_2_x ctf 0
scoreboard players set red_corner_2_y ctf 0
scoreboard players set red_corner_2_z ctf 0
scoreboard players set blue_corner_1_x ctf 0
scoreboard players set blue_corner_1_y ctf 0
scoreboard players set blue_corner_1_z ctf 0
scoreboard players set blue_corner_2_x ctf 0
scoreboard players set blue_corner_2_y ctf 0
scoreboard players set blue_corner_2_z ctf 0
scoreboard players set red_min_x ctf 0
scoreboard players set red_max_x ctf 0
scoreboard players set red_min_y ctf 0
scoreboard players set red_max_y ctf 0
scoreboard players set red_min_z ctf 0
scoreboard players set red_max_z ctf 0
scoreboard players set blue_min_x ctf 0
scoreboard players set blue_max_x ctf 0
scoreboard players set blue_min_y ctf 0
scoreboard players set blue_max_y ctf 0
scoreboard players set blue_min_z ctf 0
scoreboard players set blue_max_z ctf 0

# Reset global setup and flag state.
scoreboard players set bounds_set ctf 0
scoreboard players set has_red_flag ctf 0
scoreboard players set has_blue_flag ctf 0

# Reset all trigger values for online players.
scoreboard players set @a PlaceRedFlag 0
scoreboard players set @a PlaceBlueFlag 0
scoreboard players set @a BCorner1 0
scoreboard players set @a BCorner2 0
scoreboard players set @a RCorner1 0
scoreboard players set @a RCorner2 0
scoreboard players set @a Kit 0
scoreboard players set @a RedTeam 0
scoreboard players set @a BlueTeam 0
scoreboard players set @a LeaveTeam 0
scoreboard players set @a Disable_Game 0
scoreboard players set @a Info 0

# Set up the sidebar point display and initialize both teams to zero.
scoreboard objectives modify Points displayname {"text":"Points","color":"gold","bold":true}
# Clear old fake-player rows so stale white entries do not remain on reload.
scoreboard players reset * Points
scoreboard players set "Red" Points 0
scoreboard players set "Blue" Points 0
scoreboard players display name "Red" Points {"text":"Red","color":"red"}
scoreboard players display name "Blue" Points {"text":"Blue","color":"blue"}
scoreboard players reset @a[name=!"Red",name=!"Blue"] Points

# Clear active effects and recreate the two teams.
effect clear @a
team add Red
team add Blue

# Configure team colors, membership, and friendly-fire rules.
team modify Red color red
team modify Blue color blue
team leave @a

# Send the clickable setup guide to everyone online.
tellraw @a [{"text":"Capture The Flag datapack loaded.\n\n","color":"green"},{"text":"Step 1: Set Red Team's Corners using ","color":"red"},{"text":"/trigger RCorner 1 ","color":"red",click_event:{"action":"run_command","command":"/trigger RCorner1",},hover_event:{"action":"show_text","value":"Set Red Team's First Corner"}},{"text":"and ","color":"green"},{"text":"/trigger RCorner 2","color":"red",click_event:{action:"run_command",command:"/trigger RCorner2",},hover_event:{action:"show_text",value:"Set Red Team's Second Corner"}},{"text":"\n\n","color":"green"},{"text":"Step 2: Set Blue Teams corners using ","color":"blue"},{"text":"/trigger BCorner 1 ","color":"blue",click_event:{"action":"run_command","command":"/trigger BCorner1",},hover_event:{"action":"show_text","value":"Set Blue Team's First Corner"}},{"text":"and ","color":"green"},{"text":"/trigger BCorner 2","color":"blue",click_event:{action:"run_command",command:"/trigger BCorner2"},hover_event:{action:"show_text",value:"Set Blue Team's Second Corner"}},{"text":"\n\nStep 3: Join a team with ","color":"green"},{"text":"/trigger RedTeam ","color":"red",click_event:{"action":"run_command","command":"/trigger RedTeam",},hover_event:{"action":"show_text","value":"Join Red Team"}},{"text":"or ","color":"green"},{"text":"/trigger BlueTeam ","color":"blue",click_event:{"action":"run_command","command":"/trigger BlueTeam",},hover_event:{"action":"show_text","value":"Join Blue Team"}},{"text":"(/trigger LeaveTeam If Needed)","color":"green",click_event:{"action":"run_command","command":"/trigger LeaveTeam"}},{"text":"\n\nStep 4: Place Flags With ","color":"green"},{"text":"/trigger PlaceBlueFlag ","color":"blue",click_event:{"action":"run_command","command":"/trigger PlaceBlueFlag",},hover_event:{"action":"show_text","value":"Place Blue Flag"}},{"text":"and ","color":"green"},{"text":"/trigger PlaceRedFlag","color":"red",click_event:{"action":"run_command","command":"/trigger PlaceRedFlag",},hover_event:{"action":"show_text","value":"Place Red Flag"}},{"text":"\n\nStep 5: Get your kit with /trigger Kit","color":"green",click_event:{"action":"run_command","command":"/trigger Kit"}},{"text":"\nYOUR INVENTORY WILL BE CLEARED UPON RECEIVING YOUR KIT","color":"dark_red"}]

# Reset player flag state and create health tracking.
scoreboard players set @a has_red_flag 0
scoreboard players set @a has_blue_flag 0
scoreboard players set @a bow_used 0
scoreboard objectives add health health
scoreboard players set @a health 20

# Remove old flag markers and clear any flag helmets.
kill @e[type=marker]
item replace entity @a armor.head with air

# Keep inventories on death and reset one-time kit tracking.
gamerule keep_inventory true
tag @a remove kit_given

# Hide enemy nametags and disable friendly fire.
team modify Blue nametagVisibility hideForOtherTeams
team modify Red nametagVisibility hideForOtherTeams
team modify Blue friendlyFire false
team modify Red friendlyFire false 

# Clear stale red flag pickup tags and show points in the sidebar.
tag @a remove red_flag_taken
scoreboard objectives setdisplay sidebar Points
