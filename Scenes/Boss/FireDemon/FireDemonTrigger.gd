extends Area2D

var demon = null


func _ready():
	add_to_group("fire_demon_triggers") 

func _physics_process(delta):
	if demon == null:
		return
	for area in get_overlapping_areas():
		if area.get_parent().get_name().find('Player') != -1:
			demon.triggered = true
			


func set_fire_demon(d):
	demon = d
