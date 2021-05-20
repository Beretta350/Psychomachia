extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var check = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

	
func unpause(timeline_name):
	get_tree().paused=false


func _on_Area2D_body_entered(body):
	if body.name=="Player":
		if check==false:
			get_tree().paused=true
			var dialog = Dialogic.start('socrates')	
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)
			check=true
