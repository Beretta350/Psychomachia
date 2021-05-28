extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if(Input.is_action_just_pressed("ui_cancel")) or Input.is_action_just_pressed("ui_accept"):
		$FadeIn.show()
		$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Scenes/Menus/Main/Menu.tscn")
