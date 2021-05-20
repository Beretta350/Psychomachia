extends KinematicBody2D

const GRAVITY = 60
const SPEED = 150
const SPEED_ATTACK = 200

var velocity = Vector2()
var direction = 1
var hit = false

onready var attack_timer = $Timers/AttackTimer
onready var animations = $Body/Animation/AnimationPlayer
onready var object_body = $Body

var player = null

func _ready():
	animations.play("walk")
	add_to_group("enemies") # Replace with function body.
	
func _physics_process(delta):
	velocity.x = SPEED * direction
	
	if (player != null): 
		if (player.global_position - global_position).length() < 300:
			animations.play("attack")
			velocity.x = SPEED_ATTACK * direction
			if player.global_position.x - global_position.x > 0:
				direction = 1
			else:
				direction = -1	
		else:
			animations.play("walk")
	if direction == 1:
		object_body.scale.x = -1
	else:
		object_body.scale.x = 1

	velocity += Vector2.DOWN * GRAVITY

	velocity = move_and_slide(velocity, Vector2.UP, true)	
	
	if is_on_wall() and (player.global_position - global_position).length() >= 300:
		direction = direction * -1

func set_player(p):
	player = p
