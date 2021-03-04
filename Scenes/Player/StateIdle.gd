extends BasePlayerState

func run(player: KinematicBody2D):
	if player.vy > 0:
		player.vy = 0
	if player.ladder_area and (\
		(player.vertical < 0 and not player.ladder_tip) or \
		(player.vertical > 0 and player.ladder_tip)\
	):
		return "ladder"
	if player.horizontal == 0 and player.vertical > 0:
		player.collision_layer = 1
		player.platform_timer.start()
		player.apply_gravity(player.gravity)
		player.move()
	if player.underwater:
		return "swim"
	if not player.grounded:
		return "air"
	if player.jumping:
		return "jump"
	if player.horizontal != 0:
		if !player.slide:
			return "walk"
		else: 
			return "slide"
	if player.attacking:
		return "light_atk"
	if player.h_attacking:
		return "heavy_atk"
	if player.bow_atk:
		return "bow_atk"
	if player.slide:
		return "slide"
	if player.heal:
		return "heal"
	if player.climbing:
		return "climb"
	return null
