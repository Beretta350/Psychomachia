extends Node

const SaveGame = preload("res://Scenes/Menus/SaveGame.gd")
const SAVE_FOLDER : String = "res://Saves/"
const SAVE_TEMPLATE_NAME : String = "save_%02d.txt"

func save(id : int):
	
	var save_game := SaveGame.new()
	save_game.current_level = get_tree().get_current_scene().get_name()
	
	var directory : Directory = Directory.new()
	if not directory.dir_exists(SAVE_FOLDER):
		directory.make_dir_recursive(SAVE_FOLDER)
	
	var save_path = SAVE_FOLDER.plus_file(SAVE_TEMPLATE_NAME % id)
	var error : int = ResourceSaver.save(save_path, save_game)
	if error != OK:
		print("ERRO AO SALVAR: %s to %s" % [id, save_path])

func load(id : int):
	
	var save_file_path : String = SAVE_FOLDER.plus_file(SAVE_TEMPLATE_NAME % id)
	var file : File = File.new()
	
	if not file.file_exists(save_file_path):
		print ("O Arquivo '%s' não existe" % save_file_path)
		return
	
	var save_game : Resource = load(save_file_path)
	get_tree().change_scene(save_game.current_level) 
