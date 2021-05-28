extends BasePlayerState

export var jump_speed : float = 680

func run(player: KinematicBody2D):
	player.jump_sound.play()
	player.vy = -jump_speed
	player.move()
	if player.underwater:
		return "swim"
	if player.hurt_box_excited:
		return "hurt"
	return "air"
	
	
	
