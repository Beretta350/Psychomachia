extends KinematicBody2D

const GRAVITY = 60
const SPEED = 150

var velocity = Vector2()
var direction = 1
var hit = false
var teleport = null

onready var attack_timer = $Timers/AttackTimer
onready var animations = $Body/Animation/AnimationPlayer
onready var object_body = $Body
onready var teleport_timer = $TeleportTimer

var player = null

func _ready():
	animations.play("walk")
	add_to_group("enemies") # Replace with function body.
	
	yield(get_tree(), "idle_frame")
	get_tree().call_group("teleport_triggers", "set_nightborne", self)
	
func _physics_process(delta):
	if teleport != null:
		velocity = Vector2(0,0)
		animations.play("teleport")
		if teleport_timer.is_stopped():
			global_position = teleport
			teleport = null
			teleport_timer.start()
	elif not teleport_timer.is_stopped():
		velocity = Vector2(0,0)
		animations.play("teleport")
	
	elif hit and attack_timer.is_stopped():
		animations.play("attack")
		velocity.x = 0
		attack_timer.start()
	elif (hit == false) and attack_timer.is_stopped():
		animations.play("walk")
		velocity.x = SPEED * direction
		if (player != null): 
			if (player.global_position - global_position).length() < 300:
				if player.global_position.x - global_position.x > 0:
					direction = 1
				else:
					direction = -1	

		if direction == 1:
			object_body.scale.x = 1
		else:
			object_body.scale.x = -1

	velocity += Vector2.DOWN * GRAVITY

	velocity = move_and_slide(velocity, Vector2.UP, true)	

	if is_on_wall() and (player.global_position - global_position).length() >= 300:
		direction = direction * -1

func set_player(p):
	player = p

func _on_AttackTimer_timeout():
	hit = false

func _on_HitArea_body_entered(body):
	if body.name == "Player":
		hit = true