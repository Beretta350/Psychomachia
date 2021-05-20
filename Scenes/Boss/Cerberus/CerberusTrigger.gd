extends Area2D


var cerberus = null

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("cerberus_trigger")
	
func _physics_process(delta):
	if cerberus == null:
		return
	for area in get_overlapping_areas():
		if area.get_parent().get_name().find('Player') != -1:
			cerberus.triggered = true

func set_cerberus(c):
	cerberus = c
