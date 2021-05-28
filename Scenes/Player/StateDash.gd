extends BasePlayerState

export var dash_speed: float = 5000

	if !player.sprite.flip_h:
		player.vx = -dash_speed
	else:
		player.vx = +dash_speed	
						
	player.move()	
	
	player.dashing=false
	if player.underwater:
		return "swim"
	if player.hurt_box_excited:
		return "hurt"
	return "idle"
	
	
	
