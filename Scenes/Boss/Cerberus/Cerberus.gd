extends KinematicBody2D

onready var anim : AnimatedSprite = $AnimatedSprite
onready var timer = $WalkingTimer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(100,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	move()


func move():
	
	if anim.animation=="walking_right":	
		
		move_and_slide(velocity, Vector2.UP, true)
	
	else:
		move_and_slide(-velocity, Vector2.UP, true)
		

func _on_WalkingTimer_timeout():
	if anim.animation=="walking_right":
		
		anim.animation="walking_left"
	
	else:
		anim.animation="walking_right"



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
