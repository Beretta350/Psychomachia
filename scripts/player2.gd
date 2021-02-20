extends KinematicBody2D

var input_direction = 0
var direction = 0

var speed_x = 0
var velocity = Vector2()
var movingright

const MAX_SPEED = 600
const ACCELERATION = 1000
const DECELERATION = 2000


func _ready():
	set_process(true)
	set_process_input(true)
	movingright = true


func _input(event):
	pass


func _process(delta):
	# INPUT
	if input_direction:
		direction = input_direction
	
	if Input.is_action_pressed("ui_right"):
		movingright = true
		$AnimatedSprite.play("walk")
		input_direction = 1
	elif Input.is_action_pressed("ui_left"):
		movingright = false
		$AnimatedSprite.play("walk")
		input_direction = -1
	else:
		input_direction = 0
		$AnimatedSprite.play("idle")
		velocity.x=0
		
	if not movingright:
		$AnimatedSprite.set_flip_h(true)
	else: 
		$AnimatedSprite.set_flip_h(false)
	
	# MOVEMENT
	if input_direction == - direction:
		speed_x /= 3
	if input_direction:
		speed_x += ACCELERATION * delta
	else:
		speed_x -= DECELERATION * delta
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	
	velocity.x = speed_x * direction
	move_and_slide(velocity)
