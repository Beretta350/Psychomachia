extends KinematicBody2D

const MOVE_SPEED = 200

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var explosionTimer : Timer = $ExplosionTimer
onready var invincible_timer : Timer = $InvincibleTimer

var exploding = false
var direction = Vector2(0,0)

var fixedx = null
var fixedy = null

var skiff = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(delta):
	move_and_collide(direction.normalized() * MOVE_SPEED  * delta)
	
	if fixedx != null:
		global_position.x = skiff.global_position.x + fixedx 
	
	if exploding == true and explosionTimer.is_stopped():
		self.kill()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func kill():
	queue_free()

func _on_HitDamage_body_entered(body):
	if invincible_timer.is_stopped():
		if exploding == false:
			exploding = true
			explosionTimer.start()
