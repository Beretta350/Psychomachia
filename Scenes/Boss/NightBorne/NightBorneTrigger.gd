extends Area2D

var night_borne = null


func _ready():
	add_to_group("nighborne_triggers") 

func _physics_process(delta):
	if night_borne == null:
		return
	for area in get_overlapping_areas():
		if area.get_parent().get_name().find('Player') != -1:
			night_borne.triggered = true
			yield(get_tree(), "idle_frame")
			get_tree().call_group("arena_walls", "enable")
			


func set_nightborne(nb):
	night_borne = nb
