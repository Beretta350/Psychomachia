extends KinematicBody2D

const MOVE_SPEED = 200

var player = null

onready var lifetimeTimer : Timer = $Lifetime
onready var explosionTimer : Timer = $ExplosionTimer

var exploding = false

func _ready():
	add_to_group("enemies") # Replace with function body.
	
func _physics_process(delta):
	
	if player == null:
		return
		
	if lifetimeTimer.is_stopped():
		self.kill()
	
	var vec_to_player = player.global_position - global_position
	
	move_and_collide(vec_to_player.normalized() * MOVE_SPEED  * delta)
	
	if exploding == true and explosionTimer.is_stopped():
		self.kill()

func kill():
	queue_free()

func set_player(p):
	player = p

func _on_HitDamage_body_entered(body):
	print(body.name)
	if not "LabaBall" in body.name and not "FireWizard" in body.name:
		if exploding == false:
			exploding = true
			explosionTimer.start()
