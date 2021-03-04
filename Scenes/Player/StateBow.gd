extends BasePlayerState

var plArrow := preload("res://Scenes/Arrow/Arrow.tscn")

func run(player: KinematicBody2D):
	player.apply_gravity(player.gravity)
	player.move()

	if player.arrow_cd_timer.is_stopped():
		shoot_arrow(player)
		player.arrow_cd_timer.start()

	if !player.bow_atk:
		return "idle"

	return null

func shoot_arrow(player: KinematicBody2D):
	var arrow := plArrow.instance()
	arrow.position = player.position
	if player.sprite.flip_h:
		arrow.speed = -arrow.speed
	get_tree().current_scene.add_child(arrow)
