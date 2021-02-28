extends KinematicBody2D

const UP = Vector2(0, -1)
const MAXJUMPS = 2
const DROP_THRU_BIT = 1

var velocity = Vector2()
var move_speed = 480
var gravity = 1200
var jump_velocity = -600
var is_grounded
var is_grable
var jumps = 0

onready var raycasts = $Raycasts
onready var player_anim = $Body/AnimatedSprite

func _physics_process(delta):
	_get_input()
	
	velocity.y += gravity * delta	
	
	velocity = move_and_slide(velocity, UP)	
	
	is_grounded = is_on_floor()
	is_grable = is_on_wall()
	
	_assign_animation()

func _input(event):
	if event.is_action_pressed("ui_jump") && jumps < MAXJUMPS:
		velocity.y += jump_velocity
		jumps += 1

func _get_input():
	#Movement
	var move_direction = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	velocity.x = move_speed * move_direction
	if move_direction != 0:
		$Body.scale.x = -move_direction
	
	#Pass to plataforms
	if Input.is_action_pressed("ui_down"):
		set_collision_mask_bit(DROP_THRU_BIT, false)
	
	if is_grounded:
		jumps = 0
		
func _assign_animation():
	var anim = "idle"
	
	if !is_grounded:
		anim = "jump"
	elif velocity.x != 0:
		anim = "walk"
	
	if player_anim.to_string() != anim:
		player_anim.play(anim)

func _on_Area2D_body_exited(body):
	set_collision_mask_bit(DROP_THRU_BIT, true)
