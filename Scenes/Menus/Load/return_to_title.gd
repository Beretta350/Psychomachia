extends Control

var scene_to_load

func _ready():
	$SaveList/Save0.grab_focus()

func _on_Back_pressed():
	scene_to_load = "res://Scenes/Menus/Main/Menu.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_Save0_pressed():
	scene_to_load = "res://Scenes/Levels/Limbo.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_Save1_pressed():
	scene_to_load = "res://Scenes/Levels/Lust.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_Save2_pressed():
	scene_to_load = "res://Scenes/Levels/Gluttony.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_Save3_pressed():
	scene_to_load = "res://Scenes/Levels/Greed.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_Save4_pressed():
	scene_to_load = "res://Scenes/Levels/Heresy.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()
	

func _on_Save5_pressed():
	scene_to_load = "res://Scenes/Levels/Heresy.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_Save6_pressed():
	scene_to_load = "res://Scenes/Levels/Violence.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_Save7_pressed():
	scene_to_load = "res://Scenes/Levels/Fraud.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_Save8_pressed():
	scene_to_load = "res://Scenes/Levels/Treachery.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()
	
func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_to_load)
