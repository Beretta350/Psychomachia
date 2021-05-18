extends KinematicBody2D

const GRAVITY = 60
var velocity = Vector2()

onready var animation : AnimationPlayer = $Body/Animation/AnimationPlayer
onready var object_body : Node2D = $Body

var attacking = false
var player = null
var direction = 1

func _ready():
	animation.play("idle")
	add_to_group("enemies")

func _physics_process(delta):
	
	if player != null:
		if player.global_position.x - global_position.x > 0:
			direction = 1
		else:
			direction = -1
		
		if direction == 1:
			object_body.scale.x = -1
		else:
			object_body.scale.x = 1
	
	velocity += Vector2.DOWN * GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP, true)

func set_player(p):
	player = p

func _on_HitArea_body_entered(body):
	print(body.name + " Entrou")
	if body.name == "Player":
		animation.play("attack")
		attacking = true
		
func _on_HitArea_body_exited(body):
	print(body.name + " Saiu")
	if body.name == "Player":
		animation.play("idle")
		attacking = false
