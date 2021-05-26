extends Area2D

var speed: float = 500

onready var sprite : AnimatedSprite = $AnimatedSprite

func _physics_process(delta):
	position.x -= speed * delta

func _ready():
	if speed < 0:
		get_node( "Sprite" ).set_flip_h( true )

func _on_Area2D_body_entered(body):
	if not "Player" in body.name:
		queue_free()


func _on_Area2D_area_entered(area):
	if "Hurt" in area.name and not "Player" in area.name:
		queue_free()
