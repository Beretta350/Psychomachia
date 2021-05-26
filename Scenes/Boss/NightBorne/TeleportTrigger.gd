extends Area2D


var nightborne = null

var player_in = false
var nb_in = false
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("teleport_triggers")
	
func _physics_process(delta):
	if nightborne == null:
		return
	if !nightborne.triggered:
		return
		
	player_in = false
	nb_in = false
	for area in get_overlapping_areas():
		if area.get_parent().get_name().find('Player') != -1:
			player_in = true
		if area.get_parent().get_name().find('NightBorneEnemy') != -1:
			nb_in = true
	if not nb_in and player_in and nightborne.teleport == null:
		nightborne.teleport = global_position
		nightborne.teleport_timer.start()



func set_nightborne(n):
	nightborne = n
