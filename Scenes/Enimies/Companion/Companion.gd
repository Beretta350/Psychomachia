extends KinematicBody2D

const MOVE_SPEED = 200

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies") # Replace with function body.
	
func _physics_process(delta):
	if player == null:
		return
	
	
	var vec_to_player = player.global_position - global_position
	
	
	if vec_to_player.length() < 50:
		return
	
	move_and_collide(vec_to_player.normalized() * MOVE_SPEED  * delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_player(p):
	player = p
