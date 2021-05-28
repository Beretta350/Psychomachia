extends Area2D


var cerberus = null
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("checkpoints")
	
func _physics_process(delta):
	if cerberus == null:
		return
	if player == null:
		return
	for area in get_overlapping_areas():
		if area.get_parent().get_name().find('Player') != -1:
			player.checkpoint = self

func set_cerberus(c):
	cerberus = c
	
func set_player(p):
	player = p
	
func reset():
	player.global_position = global_position
	player.life = 100
	cerberus.global_position = cerberus.original_position
