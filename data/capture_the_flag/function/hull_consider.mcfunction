# The very first eligible point becomes the tentative candidate. Every later
# point replaces it only if it is more clockwise (see hull_maybe).
execute if score hcand_set ctf matches 0 run function capture_the_flag:hull_take
execute if score hcand_set ctf matches 1 run function capture_the_flag:hull_maybe
