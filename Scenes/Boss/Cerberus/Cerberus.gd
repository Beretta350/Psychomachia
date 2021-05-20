extends KinematicBody2D

onready var anim : AnimatedSprite = $AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(150,0)
var triggered = false
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	
	yield(get_tree(), "idle_frame")
	get_tree().call_group("cerberus_trigger", "set_cerberus", self)

func _physics_process(delta):
	if triggered and player!=null:
		move()

func set_player(p):
	player = p

func move():
	var vec_to_player = player.global_position - global_position
	
	
	
	move_and_slide(vec_to_player.normalized() * velocity, Vector2.UP, true)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
