extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("arena_walls")
	$CollisionShape2D.disabled = true


func enable():
	$CollisionShape2D.disabled = false

func desable():
	$CollisionShape2D.disabled = true
