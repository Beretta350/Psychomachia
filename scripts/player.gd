extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 500
const JUMPFORCE = 500
const ACCEL = 40

var motion = Vector2()
var movingright = true
var jumping = false
var num_jumps = 2




# Called when the node enters the scene tree for the first time.
func _ready():
	movingright = true
	jumping = false

func get_input():
	if Input.is_action_pressed("ui_right"):
		movingright=true
		if is_on_floor():
			$AnimatedSprite.play("walk")
		motion.x += ACCEL
	elif Input.is_action_pressed("ui_left"):
		movingright=false
		if is_on_floor():
			$AnimatedSprite.play("walk")
		motion.x -= ACCEL
	else:
		if is_on_floor():
			$AnimatedSprite.play("idle")
		motion.x=lerp(motion.x, 0, 0.2)
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
		
		
	if Input.is_action_just_pressed("ui_jump") and (is_on_floor() or is_on_wall()):
		motion.y = -JUMPFORCE
		
		$AnimatedSprite.play("jump")
	
	if is_on_wall() and Input.is_action_pressed("hold"):
		motion.y = 0
		
	
		
	if not movingright:
		$AnimatedSprite.set_flip_h(true)
	else: 
		$AnimatedSprite.set_flip_h(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	get_input()
	move_and_slide(motion, UP)
