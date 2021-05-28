extends BasePlayerState

export var midair_speed : float = 300



func enter(player: KinematicBody2D):
	
	if player.anim.current_animation == "jump":
		yield (player.anim, "animation_finished")
		if player.state_machine.active_state.tag == tag:
			.enter(player) # Base class
	else:
		.enter(player) # Base class

func run(player: KinematicBody2D):
	var scene_name=player.scene_name
	player.vx = player.horizontal * midair_speed
	player.apply_gravity(player.gravity)
	player.move()
	if player.ladder_area and player.vertical != 0:
		return "ladder"
	if player.underwater:
		return "swim"
	if player.is_on_floor():
		player.grounded_sound.play()
		return "idle" if player.horizontal == 0 else "walk"
	if player.grounded and player.jumping:
		player.jumps = 0
		return "jump"
	if player.jumps < 1 and player.jumping and (scene_name!="ViolenceTemplate" && scene_name!="FraudTemplate" && scene_name!="TreacheryTemplate"):
		player.jump_sound.play()
		player.jumps += 1
		return "jump"
	if player.attacking:
		return "light_atk"
	if player.h_attacking:
		return "heavy_atk"
	if player.bow_atk:
		return "bow_atk"
	if player.climbing && player.is_on_wall:
		return "climb"
	if player.dashing:
		return "dash"
	if player.hurt_box_excited:
		return "hurt"
	return null
