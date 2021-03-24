extends KinematicBody2D

onready var timer = $ResetTimer
onready var animation_player=$AnimationPlayer

onready var reset_position = global_position

var velocity = Vector2()
var gravity=60

var is_triggered=false

export var reset_time : float = 1.0

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	velocity.y +=gravity
	position+= velocity*delta
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func collide_with(collision: KinematicCollision2D, collider: KinematicBody2D):
	if !is_triggered:
		is_triggered=true
		animation_player.play("shake")
		velocity=Vector2.ZERO
		
		
		
func _on_AnimationPlayer_animation_finished(anim_name):
	print("passou aqui")
	set_physics_process(true)
	timer.start(reset_time)
	
# Called when the node enters the scene tree for the first time.

	
func _on_ResetTimer_timeout():
	set_physics_process(false)
	yield(get_tree(), "physics_frame")
	var temp = collision_layer
	collision_layer=0
	global_position=reset_position
	yield(get_tree(), "physics_frame")
	collision_layer=temp
	is_triggered = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
