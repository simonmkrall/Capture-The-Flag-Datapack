# Delete arrows fired by players outside their own territory.
execute as @a[scores={inside_boundary=0,bow_used=1..}] at @s anchored eyes positioned ^ ^ ^1.5 run kill @e[type=minecraft:arrow,distance=..5,sort=nearest,limit=1]
scoreboard players set @a bow_used 0
