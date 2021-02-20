extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var movingright
var jumping
var velocity = Vector2()
var walkspeed=350
var gravity=200
var jumpforce=250
var FLOOR = Vector2(0,-1)
#var jumpheight = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	movingright = true
	jumping = false

func _physics_process(delta):
	velocity.y = gravity
	get_input()
	move_and_slide(velocity)


func get_input():
	if Input.is_action_pressed("ui_jump"):
		velocity.y = -jumpforce	
		jumping=true
	
	if Input.is_action_pressed("ui_right"):
		movingright=true
		velocity.x = walkspeed
		if jumping:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("walk")			
			
	elif Input.is_action_pressed("ui_left"):
		movingright=false
		velocity.x = -walkspeed
		if jumping:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("walk")
		
	else:
		$AnimatedSprite.play("idle")
		velocity.x=0
		
	if not movingright:
		$AnimatedSprite.set_flip_h(true)
	else: 
		$AnimatedSprite.set_flip_h(false)
		
	jumping = false


# Called every frame. 'delta' is the elapsed time since the previous frame.

