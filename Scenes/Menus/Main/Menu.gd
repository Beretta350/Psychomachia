extends Control

var scene_to_load

func _ready():
	$MainMenu/Buttons/NewGame.grab_focus()

func _on_NewGame_pressed():
	scene_to_load = "res://Scenes/Levels/Limbo.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_LoadGame_pressed():
	scene_to_load = "res://Scenes/Menus/Load/Load.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()
	

func _on_ExitGame_pressed():
	get_tree().quit()


func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_to_load)
