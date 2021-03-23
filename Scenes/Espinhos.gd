extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _on_DeathBlock_body_entered(body):
	if body==Player
		get_tree().reload_current_scene()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
