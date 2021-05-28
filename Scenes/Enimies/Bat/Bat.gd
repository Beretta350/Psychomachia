extends KinematicBody2D

const GRAVITY = 60
const MOVE_SPEED = 5000

onready var animations : AnimationPlayer = $Body/Animation/AnimationPlayer
onready var object_body : Node2D = $Body

export var vertical : bool = true
export var xtrigger : float = 0.0

var attacking = false
var player = null
var skiff = null
var direction = 1
var life = 100

var objective = null


var column = randi()%5+1
var row = randi()%3+1
onready var attack_timer : Timer = $AttackTimer

var plProjectile := preload("res://Scenes/Enimies/Bat/BatProjectile.tscn")

func _ready():
	animations.play("walk")
	add_to_group("enemies")

func _physics_process(delta):
	
	if xtrigger < global_position.x:
		return
	
	if player != null and skiff != null:
		
		if vertical == true:
			if attack_timer.is_stopped() and attacking:
				var projectile := plProjectile.instance()
				projectile.position = global_position 
				projectile.direction = Vector2(0,1)
				projectile.skiff = skiff
				projectile.fixedx = global_position.x - skiff.global_position.x
				get_tree().current_scene.add_child(projectile)
				attacking = false
			
			if attack_timer.is_stopped():
				animations.play("walk")
				
				if column == 1:
					objective = skiff.global_position + Vector2(50,-170)
				elif column == 2:
					objective = skiff.global_position + Vector2(-50,-170)
				elif column == 3:
					objective = skiff.global_position + Vector2(-25,-170)
				elif column == 4:
					objective = skiff.global_position + Vector2(25,-170)
				elif column == 5:
					objective = skiff.global_position + Vector2(0,-170)
				
				var vec_to_objective = objective - global_position
				
				if vec_to_objective.x > 0:
					object_body.scale.x = 1
				if vec_to_objective.x < 0:
					object_body.scale.x = -1
				
				if vec_to_objective.length() < 1:
					column = randi()%5+1
					attacking = true
					attack_timer.start()
					
				move_and_slide(vec_to_objective.normalized() * MOVE_SPEED  * delta)
			else:
				animations.play("attack")
		
		else:
			if attack_timer.is_stopped() and attacking:
				var projectile := plProjectile.instance()
				projectile.position = global_position 
				projectile.direction = Vector2(-1,0)
				projectile.skiff = skiff
				projectile.fixedy = global_position.y - skiff.global_position.y
				get_tree().current_scene.add_child(projectile)
				attacking = false
			
			if attack_timer.is_stopped():
				animations.play("walk")
				
				if row == 1:
					objective = skiff.global_position + Vector2(150,-55)
				elif row == 2:
					objective = skiff.global_position + Vector2(150,-35)
				elif row == 3:
					objective = skiff.global_position + Vector2(150,-15)
				
				var vec_to_objective = objective - global_position
				
				if vec_to_objective.x > 0:
					object_body.scale.x = 1
				if vec_to_objective.x < 0:
					object_body.scale.x = -1
				
				if vec_to_objective.length() < 1:
					row = randi()%3+1
					attacking = true
					attack_timer.start()
					
				move_and_slide(vec_to_objective.normalized() * MOVE_SPEED  * delta)
			else:
				animations.play("attack")
		
		
	

func set_player(p):
	player = p
	
func set_skiff(s):
	skiff = s
