extends KinematicBody2D

const MOVE_SPEED = 200

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player = null

onready var lifetimeTimer : Timer = $Lifetime
onready var explosionTimer : Timer = $ExplosionTimer

var exploding = false

# Called when the node enters the scene tree for the first time.
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func kill():
	queue_free()

func set_player(p):
	player = p


func _on_HitDamage_body_entered(body):
	if body.name != 'KinematicBody2D':
		if exploding == false:
			exploding = true
			explosionTimer.start()
