extends KinematicBody2D

const GRAVITY = 60
const SPEED = 70

var velocity = Vector2()
var direction = 1
var hit = false

onready var attack_timer = $Timers/AttackTimer
onready var animations = $Body/Animation/AnimationPlayer
onready var object_body = $Body

var player = null

func _ready():
	add_to_group("enemies") # Replace with function body.
	
func _physics_process(delta):
	
		
	if hit and attack_timer.is_stopped():
		animations.play("attack")
		velocity.x = 0
		attack_timer.start()
	elif (hit == false) and attack_timer.is_stopped():
		if player == null:
			return
		
		if player.global_position.x - global_position.x > 0:
			direction = 1
		else:
			direction = -1
		
		if direction == 1:
			object_body.scale.x = -1
		else:
			object_body.scale.x = 1
			
		velocity.x = SPEED * direction
				
		animations.play("jump")
	
	
	if (player.global_position - global_position).length() < 200:
		velocity = move_and_slide(velocity, Vector2.UP, true)
	else:
		velocity.x = 0
		velocity = move_and_slide(velocity, Vector2.UP, true)
		
	velocity += Vector2.DOWN * GRAVITY
	
func set_player(p):
	player = p


func _on_AttackTimer_timeout():
	hit = false

func _on_HitArea_body_entered(body):
	if body.name == "Player":
		hit = true
