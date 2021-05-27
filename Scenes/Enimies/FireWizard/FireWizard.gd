extends KinematicBody2D

const GRAVITY = 60
var velocity = Vector2()

onready var animations : AnimationPlayer = $Body/Animation/AnimationPlayer
onready var object_body : Node2D = $Body

var attacking = false
var player = null
var direction = 1
var life = 100

onready var lavaBallCD : Timer = $LavaBallCD
onready var hit_sound = $Body/Animation/Hit
onready var start_atk_sound = $Body/Animation/StartAttack

var plLavaball := preload("res://Scenes/Enimies/FireWizard/lavaball.tscn")

func _ready():
	animations.play("idle")
	add_to_group("enemies")

func _physics_process(delta):
	if life <= 0:
		animations.play("death")
	else:
		if player != null:
			if player.global_position.x - global_position.x > 0:
				direction = 1
			else:
				direction = -1
			
			if direction == 1:
				object_body.scale.x = -1
			else:
				object_body.scale.x = 1
				
			if attacking and lavaBallCD.is_stopped():
				var lavaball := plLavaball.instance()
				lavaball.position = position + Vector2(0,-30)
				lavaball.player = player
				get_tree().current_scene.add_child(lavaball)
				lavaBallCD.start()
		
		velocity += Vector2.DOWN * GRAVITY
		velocity = move_and_slide(velocity, Vector2.UP, true)
	

func set_player(p):
	player = p

func _on_HitArea_body_entered(body):
	if body.name == "Player":
		animations.play("attack")
		start_atk_sound.play()
		attacking = true

func _on_HitArea_body_exited(body):
	if body.name == "Player":
		animations.play("idle")
		attacking = false

func _on_HurtArea_area_entered(area):
	if "PlayerLightDamage" in area.name:
		hit_sound.play()
		life -= 30
	elif "PlayerHeavyDamage" in area.name:
		hit_sound.play()
		life -= 50

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
