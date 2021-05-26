extends KinematicBody2D

onready var anim : AnimatedSprite = $AnimatedSprite
onready var object_body : Node2D = $Body
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(100,0)
var triggered = false
var player = null
var original_position = null

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	
	yield(get_tree(), "idle_frame")
	get_tree().call_group("cerberus_trigger", "set_cerberus", self)
	get_tree().call_group("checkpoints", "set_cerberus", self)
	
	original_position = global_position

func _physics_process(delta):
	if triggered and player!=null:
		move()

func set_player(p):
	player = p

func move():
	if global_position.x < 388:
		return
	
	var vec_to_player = player.global_position - global_position
	
	if vec_to_player.x > 0:
		object_body.scale.x = -1
	if vec_to_player.x < 0:
		object_body.scale.x = 1
	
	move_and_slide(vec_to_player.normalized() * velocity, Vector2.UP, true)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
