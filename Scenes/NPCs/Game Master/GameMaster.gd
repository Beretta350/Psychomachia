extends Node2D

onready var animations = $AnimationPlayer
var killable = false

func _ready():
	add_to_group("game_master")
	animations.play("default")

func _on_HurtArea_area_entered(area):
	if "PlayerLightDamage" in area.name and killable == true:
		animations.play("death")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "death":
		self.death()

func death():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("fire", "queue_free")
	
func set_killable():
	killable = true
