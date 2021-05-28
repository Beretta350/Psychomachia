extends KinematicBody2D

onready var timer = $MovingTimer
onready var animation_player=$AnimationPlayer

onready var reset_position = global_position

var velocity = Vector2(0,0)



export var reset_time : float = 3.0

var  going_down : bool = false


func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("enemies", "set_skiff", self)

func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP, true)
	self.transform.origin.y = 0
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if(get_slide_collision(i).collider.get_name().find("Player") != -1):
			velocity = Vector2(-50,0)
			collision.collider.move_and_slide(velocity, Vector2.UP, true)
			
		
