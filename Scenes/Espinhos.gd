extends TileMap

func _on_DeathBlock_body_entered(body):
	if body==Player:
		get_tree().reload_current_scene()
