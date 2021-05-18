extends BasePlayerState

export var dash_speed: float = 5000

#const max_distance = 5000
#var distance_travelled: float = 0


func run(player: KinematicBody2D):
#	print("Hi")
#	player.dash_timer.start()
#	while(distance_travelled < 5500):
#		print("hi")			
#		if player.dash_timer.is_stopped():
#			print(player.dash_timer.is_stopped())
	if !player.sprite.flip_h:
		player.vx = -dash_speed
	else:
		player.vx = +dash_speed	
				
#			distance_travelled += dash_speed
		
	player.move()	
#	player.dash_timer.start()
	
	player.dashing=false
#	distance_travelled = 0
	if player.underwater:
		return "swim"
	if player.hurt_box_excited:
		return "hurt"
	return "idle"
	
	
	
