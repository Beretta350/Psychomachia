extends Control

var scene_to_load
var level_reached = 0

func _ready():
	$SaveList/Save0.grab_focus()
	
	var level_file = File.new()
	
	if !level_file.file_exists("res://save/max_level.dat"):
		print("creating file")
		level_file.open("res://save/max_level.dat", File.WRITE)
		level_file.store_8(level_reached)
		level_file.close()
	
	
	level_file.open("res://save/max_level.dat", File.READ)
	level_reached = level_file.get_8()
	level_file.close()
	
	if level_reached < 1:
		$SaveList/Save1.hide()
	if level_reached < 2:
		$SaveList/Save2.hide()
	if level_reached < 3:
		$SaveList/Save3.hide()
	if level_reached < 4:
		$SaveList/Save4.hide()
	if level_reached < 5:
		$SaveList/Save5.hide()
	if level_reached < 6:
		$SaveList/Save6.hide()
	if level_reached < 7:
		$SaveList/Save7.hide()
	if level_reached < 8:
		$SaveList/Save8.hide()

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
