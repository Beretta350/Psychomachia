extends BasePlayerState


func run(player: KinematicBody2D):
	if !player.attacking:
		return "idle"
		
	return null
