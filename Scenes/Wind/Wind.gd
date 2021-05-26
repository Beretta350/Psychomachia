extends Area2D                       

class_name Wind


export var wind_force: Vector2 = Vector2.ZERO


func _ready():
	
	add_to_group("wind")
	

func _physics_process(delta):
	for area in get_overlapping_areas():
		if area.get_parent().get_name().find('Player') != -1:
			area.get_parent().forces += wind_force
			

func deactivate():
	self.hide()
	wind_force = Vector2.ZERO
