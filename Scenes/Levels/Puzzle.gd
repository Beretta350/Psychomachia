extends Area2D

var check = false
	
func unpause(timeline_name):
	get_tree().paused=false


func _on_Puzzle_body_entered(body):
	if body.name=="Player":
		if check==false:
			yield(get_tree(), "idle_frame")
			get_tree().call_group("game_master", "set_killable")
			get_tree().paused=true
			var dialog = Dialogic.start('gamemaster')	
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)
			check=true
	
