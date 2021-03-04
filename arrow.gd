extends Area2D

var speed: float = 500

onready var sprite : AnimatedSprite = $AnimatedSprite

func _physics_process(delta):
	position.x -= speed * delta

func _ready():
	if speed < 0:
		get_node( "Sprite" ).set_flip_h( true )
