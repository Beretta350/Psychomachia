extends KinematicBody2D

onready var timer = $MovingTimer
onready var animation_player=$AnimationPlayer

onready var reset_position = global_position

var velocity = Vector2(-100,0)


var is_movingLeft=true

export var reset_time : float = 3.0

var  going_down : bool = false


func _ready():
	pass

func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP, true)
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if(get_slide_collision(i).collider.get_name().find("Player") != -1):
			collision.collider.move_and_slide(velocity, Vector2.UP, true)
		if(get_slide_collision(i).collider.has_method("is_border")):
			if going_down == false:
				velocity.y += 100
				timer.start()
			going_down = true
			
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _on_MovingTimer_timeout():	
		velocity.y = 0
		velocity.x = -velocity.x
		going_down = false
		
