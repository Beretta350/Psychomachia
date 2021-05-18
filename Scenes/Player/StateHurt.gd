extends BasePlayerState

func run(player: KinematicBody2D):
	player.vx = 0
	player.apply_gravity(player.gravity)
	player.move()
	if player.underwater:
		return "swim"
	if not player.grounded:
		return "air"
	if player.jumping:
		return "jump"
	if player.horizontal != 0 and !player.was_hited:
		return "walk"
	elif !player.was_hited:
		return "idle"
	if player.underwater:
		return "swim"
	if player.heal:
		return "heal"
	if player.climbing:
		return "climb"
	if player.dashing:
		return "dash"
		
	return null
