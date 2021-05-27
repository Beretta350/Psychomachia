extends KinematicBody2D

const GRAVITY = 60
const SPEED = 100

var velocity = Vector2()
var direction = 1
var attack = false
var life = 50


onready var attack_timer = $Timers/AttackTimer
onready var animations = $Body/Animation/AnimationPlayer
onready var object_body = $Body
onready var hit_sound = $Body/Animation/Hit

func _physics_process(delta):
	
	if life <= 0:
		animations.play("death")
	else:
		if attack and attack_timer.is_stopped():
			animations.play("attack")
			velocity.x = 0
			attack_timer.start()
		elif (attack == false) and attack_timer.is_stopped():
			velocity.x = SPEED * direction
			if direction == 1:
				object_body.scale.x = -1
			else:
				object_body.scale.x = 1
					
			animations.play("jump")
		
		velocity += Vector2.DOWN * GRAVITY
			
		velocity = move_and_slide(velocity, Vector2.UP, true)
		
		if is_on_wall():
			direction = direction * -1


func _on_AttackTimer_timeout():
	attack = false

func _on_HitArea_body_entered(body):
	if body.name == "Player":
		attack = true
		
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
