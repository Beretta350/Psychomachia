extends Control

func _ready():
	$SaveList/Save0.grab_focus()

func _on_Back_pressed():
	get_tree().change_scene("res://Scenes/Menus/Main/Menu.tscn")
