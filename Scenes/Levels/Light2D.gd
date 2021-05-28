extends Light2D

var exploding = false


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("light")




func _process(delta):
	if exploding:
		energy += delta * 0.5
		texture_scale += delta * 1
		if energy>4:
			exploding=false
			$FadeIn.show()
			$FadeIn.fade_in()




func light_explosion():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("HUD", "set_scale", Vector2(0,0))
	exploding = true


func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Scenes/Menus/Credits/Credits.tscn")
