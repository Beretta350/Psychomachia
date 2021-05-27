extends CollisionShape2D

func _on_Next_Scene_body_entered(body):
	var curret_level = get_tree().get_current_scene().get_name()
	if body.name =="Player":
		if curret_level == "LimboTemplate":
			save_progress(1)
			get_tree().change_scene("res://Scenes/Levels/Lust.tscn")
		elif curret_level == "LustTemplate":
			save_progress(2)
			get_tree().change_scene("res://Scenes/Levels/Gluttony.tscn")
		elif curret_level == "GluttonyTemplate":
			save_progress(3)
			get_tree().change_scene("res://Scenes/Levels/Greed.tscn")
		elif curret_level == "GreedTemplate":
			save_progress(4)
			get_tree().change_scene("res://Scenes/Levels/Wrath.tscn")
		elif curret_level == "WrathTemplate":
			save_progress(5)
			get_tree().change_scene("res://Scenes/Levels/Heresy.tscn")
		elif curret_level == "HeresyTemplate":
			save_progress(6)
			get_tree().change_scene("res://Scenes/Levels/Violence.tscn")
		elif curret_level == "ViolenceTemplate":
			save_progress(7)
			get_tree().change_scene("res://Scenes/Levels/Fraud.tscn")
		elif curret_level == "FraudTemplate":
			save_progress(8)
			get_tree().change_scene("res://Scenes/Levels/Treachery.tscn")

func save_progress(next_level):
	var level_file = File.new()
	
	var directory = Directory.new( )
	if !directory.dir_exists("save"):
		directory.open(OS.get_executable_path().get_base_dir())
		directory.make_dir("save")
	
	if level_file.file_exists("save/max_level.dat"):
		level_file.open("save/max_level.dat", File.READ)
		if level_file.get_8() > next_level:
			level_file.close()
			return
		level_file.close()
	
	level_file.open("save/max_level.dat", File.WRITE)
	level_file.store_8(next_level)
	level_file.close()
