# Main storage objective for shared datapack values.
scoreboard objectives add ctf dummy

# Boundary objectives. bounds_set, red_closed, blue_closed and all polygon
# math scratch values live as holders in the shared "ctf" objective; only the
# per-player inside_boundary flag needs its own objective.
scoreboard objectives add bounds_set dummy
scoreboard objectives add inside_boundary dummy
scoreboard objectives add prev_inside dummy

# Per-player flag-carrying state.
scoreboard objectives add has_red_flag dummy
scoreboard objectives add has_blue_flag dummy
scoreboard objectives add bow_used minecraft.used:minecraft.bow

# Trigger objectives players use as clickable commands.
scoreboard objectives add PlaceRedFlag trigger
scoreboard objectives add PlaceBlueFlag trigger
scoreboard objectives add RAddPoint trigger
scoreboard objectives add RClose trigger
scoreboard objectives add RUndo trigger
scoreboard objectives add RClear trigger
scoreboard objectives add BAddPoint trigger
scoreboard objectives add BClose trigger
scoreboard objectives add BUndo trigger
scoreboard objectives add BClear trigger
scoreboard objectives add ShowBounds trigger
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

# Reset both boundary polygons so each game is set up fresh.
data modify storage capture_the_flag:poly red_verts set value []
data modify storage capture_the_flag:poly blue_verts set value []
data modify storage capture_the_flag:poly red_hull set value []
data modify storage capture_the_flag:poly blue_hull set value []
data modify storage capture_the_flag:poly red_edges set value []
data modify storage capture_the_flag:poly blue_edges set value []
scoreboard players set red_closed ctf 0
scoreboard players set blue_closed ctf 0

# Assume everyone starts inside so the first tick never fires a crossing cue.
scoreboard players set @a prev_inside 1

# Boundary overlay state and math constants used by the particle drawing.
scoreboard players set show_bounds ctf 0
scoreboard players set draw_color ctf 0
scoreboard players set neg1 ctf -1
scoreboard players set two ctf 2

# Reset global setup and flag state.
scoreboard players set bounds_set ctf 0
scoreboard players set has_red_flag ctf 0
scoreboard players set has_blue_flag ctf 0

# Reset all trigger values for online players.
scoreboard players set @a PlaceRedFlag 0
scoreboard players set @a PlaceBlueFlag 0
scoreboard players set @a RAddPoint 0
scoreboard players set @a RClose 0
scoreboard players set @a RUndo 0
scoreboard players set @a RClear 0
scoreboard players set @a BAddPoint 0
scoreboard players set @a BClose 0
scoreboard players set @a BUndo 0
scoreboard players set @a BClear 0
scoreboard players set @a ShowBounds 0
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
tellraw @a [{"text":"Capture The Flag datapack loaded.\n\n","color":"green"},{"text":"Step 1: Define Red's area. Stand at each corner of the area and run ","color":"red"},{"text":"/trigger RAddPoint","color":"red",click_event:{action:"run_command",command:"/trigger RAddPoint"},hover_event:{action:"show_text",value:"Add a Red boundary point at your position"}},{"text":", then ","color":"green"},{"text":"/trigger RClose","color":"red",click_event:{action:"run_command",command:"/trigger RClose"},hover_event:{action:"show_text",value:"Finish the Red area (needs 3+ points)"}},{"text":" to finish. ","color":"green"},{"text":"[Undo]","color":"gray",click_event:{action:"run_command",command:"/trigger RUndo"},hover_event:{action:"show_text",value:"Remove the last Red point"}},{"text":" ","color":"green"},{"text":"[Clear]","color":"gray",click_event:{action:"run_command",command:"/trigger RClear"},hover_event:{action:"show_text",value:"Clear all Red points"}},{"text":"\n\n","color":"green"},{"text":"Step 2: Define Blue's area. Stand at each corner of the area and run ","color":"blue"},{"text":"/trigger BAddPoint","color":"blue",click_event:{action:"run_command",command:"/trigger BAddPoint"},hover_event:{action:"show_text",value:"Add a Blue boundary point at your position"}},{"text":", then ","color":"green"},{"text":"/trigger BClose","color":"blue",click_event:{action:"run_command",command:"/trigger BClose"},hover_event:{action:"show_text",value:"Finish the Blue area (needs 3+ points)"}},{"text":" to finish. ","color":"green"},{"text":"[Undo]","color":"gray",click_event:{action:"run_command",command:"/trigger BUndo"},hover_event:{action:"show_text",value:"Remove the last Blue point"}},{"text":" ","color":"green"},{"text":"[Clear]","color":"gray",click_event:{action:"run_command",command:"/trigger BClear"},hover_event:{action:"show_text",value:"Clear all Blue points"}},{"text":"\n\nPreview your areas anytime with ","color":"green"},{"text":"/trigger ShowBounds","color":"gold",click_event:{action:"run_command",command:"/trigger ShowBounds"},hover_event:{action:"show_text",value:"Toggle the boundary particle overlay on/off"}},{"text":" (toggles a colored particle outline).","color":"green"},{"text":"\n\nStep 3: Join a team with ","color":"green"},{"text":"/trigger RedTeam ","color":"red",click_event:{"action":"run_command","command":"/trigger RedTeam",},hover_event:{"action":"show_text","value":"Join Red Team"}},{"text":"or ","color":"green"},{"text":"/trigger BlueTeam ","color":"blue",click_event:{"action":"run_command","command":"/trigger BlueTeam",},hover_event:{"action":"show_text","value":"Join Blue Team"}},{"text":"(/trigger LeaveTeam If Needed)","color":"green",click_event:{"action":"run_command","command":"/trigger LeaveTeam"}},{"text":"\n\nStep 4: Place Flags With ","color":"green"},{"text":"/trigger PlaceBlueFlag ","color":"blue",click_event:{"action":"run_command","command":"/trigger PlaceBlueFlag",},hover_event:{"action":"show_text","value":"Place Blue Flag"}},{"text":"and ","color":"green"},{"text":"/trigger PlaceRedFlag","color":"red",click_event:{"action":"run_command","command":"/trigger PlaceRedFlag",},hover_event:{"action":"show_text","value":"Place Red Flag"}},{"text":"\n\nStep 5: Get your kit with /trigger Kit","color":"green",click_event:{"action":"run_command","command":"/trigger Kit"}},{"text":"\nYOUR INVENTORY WILL BE CLEARED UPON RECEIVING YOUR KIT","color":"dark_red"}]

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
