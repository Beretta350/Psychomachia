extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var movingright
var jumping
var velocity = Vector2()
var walkspeed=350
var gravity=200
var jumpforce=150


# Called when the node enters the scene tree for the first time.
func _ready():
	movingright = true
	jumping = false

func get_input():
	if Input.is_action_pressed("ui_right"):
		movingright=true
		$AnimatedSprite.play("walk")
		velocity.x = walkspeed
	elif Input.is_action_pressed("ui_left"):
		movingright=false
		$AnimatedSprite.play("walk")
		velocity.x = -walkspeed
	elif Input.is_action_pressed("ui_jump"):
		velocity.y = -jumpforce
		$AnimatedSprite.play("jump")			
	else:
		$AnimatedSprite.play("idle")
		velocity.x=0
		
	if not movingright:
		$AnimatedSprite.set_flip_h(true)
	else: 
		$AnimatedSprite.set_flip_h(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y = gravity
	get_input()
	move_and_slide(velocity)
