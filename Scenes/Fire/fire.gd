extends Area2D

func _ready():
	add_to_group("fire")

func _on_Fire_body_entered(body):
	if body.name=="Player":
		get_tree().reload_current_scene() 
