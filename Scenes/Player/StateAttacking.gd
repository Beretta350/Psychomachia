extends BasePlayerState


func run(player: KinematicBody2D):
	player.apply_gravity(player.gravity)
	player.move()
	
	if !player.attacking:
		return "idle"
		
	return null
