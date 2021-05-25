extends CollisionShape2D

func _on_Next_Scene_body_entered(body):
	var curret_level = get_tree().get_current_scene().get_name()
	if body.name =="Player":
		if curret_level == "LimboTemplate":
			get_tree().change_scene("res://Scenes/Levels/Lust.tscn")
		elif curret_level == "LustTemplate":
			get_tree().change_scene("res://Scenes/Levels/Gluttony.tscn")
		elif curret_level == "GluttonyTemplate":
			get_tree().change_scene("res://Scenes/Levels/Greed.tscn")
		elif curret_level == "GreedTemplate":
			get_tree().change_scene("res://Scenes/Levels/Wrath.tscn")
		elif curret_level == "WrathTemplate":
			get_tree().change_scene("res://Scenes/Levels/Heresy.tscn")
		elif curret_level == "HeresyTemplate":
			get_tree().change_scene("res://Scenes/Levels/Violence.tscn")
		elif curret_level == "ViolenceTemplate":
			get_tree().change_scene("res://Scenes/Levels/Fraud.tscn")
		elif curret_level == "FraudTemplate":
			get_tree().change_scene("res://Scenes/Levels/Treachery.tscn")

