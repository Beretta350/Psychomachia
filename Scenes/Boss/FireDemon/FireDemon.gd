extends KinematicBody2D
const SPEED = 70

var velocity = Vector2()
var vec_to_pos = Vector2()
var pos = 0
var attacking = false
var triggered = false

onready var animation : AnimationPlayer = $Body/Animation/AnimationPlayer
onready var object_body : Node2D = $Body

onready var attackTimer : Timer = $AttackTimer

const pos_0 = Vector2(236,391)
const pos_1 = Vector2(260,280)
const pos_2 =  Vector2(236,168)
const pos_3 = Vector2(260,56)



func _ready():
	add_to_group("enemies") 
	yield(get_tree(), "idle_frame")
	get_tree().call_group("fire_demon_triggers", "set_fire_demon", self)
	
	animation.play("iddle")

func _physics_process(delta):
	if triggered == false:
		return
	
	if attackTimer.is_stopped():
		attacking = false
	if attacking:
		animation.play("attack")
		return
	
	animation.play("idle")
	if pos == 0:
		object_body.scale.x = 1
		vec_to_pos = pos_0 - global_position 
		if vec_to_pos.length() < 1:
			attackTimer.start()
			attacking = true
			pos += 1
	elif pos == 1:
		object_body.scale.x = -1
		vec_to_pos = pos_1 - global_position 
		if vec_to_pos.length() < 1:
			attackTimer.start()
			attacking = true
			pos += 1
	elif pos == 2:
		object_body.scale.x = 1
		vec_to_pos = pos_2 - global_position 
		if vec_to_pos.length() < 1:
			attackTimer.start()
			attacking = true
			pos += 1 
	elif pos == 3:
		object_body.scale.x = -1
		vec_to_pos = pos_3 - global_position 
		if vec_to_pos.length() < 1:
			attackTimer.start()
			attacking = true
			pos += 1
	
	if pos == 4:
		pos = 0
	
	move_and_collide(vec_to_pos.normalized() * SPEED  * delta)
	
func death():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("invisible wall", "queue_free")
