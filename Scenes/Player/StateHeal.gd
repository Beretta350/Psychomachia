extends BasePlayerState


func run(player: KinematicBody2D):
	player.apply_gravity(player.gravity)
	player.move()
	
	if !player.heal:
		return "idle"
	if player.hurt_box_excited:
		return "hurt"
	return null
