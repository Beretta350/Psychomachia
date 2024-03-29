extends KinematicBody2D
class_name Player
signal hud

export var gravity : float = 60

var horizontal : int = 0
var vertical : int = 0
var up : bool = false
var velocity: Vector2 = Vector2.ZERO
var forces: Vector2 = Vector2.ZERO
var vx: float = 0 setget _set_vx, _get_vx
var vy: float = 0 setget _set_vy

var underwater : bool = false
var attacking : bool = false
var h_attacking : bool = false
var grounded : bool = false setget ,_get_grounded
var jumping : bool = false setget ,_get_jumping
var ladder_area : bool = false
var ladder_tip : bool = false
var ladder_x : float
var jumps : int = 0
var bow_atk : bool = false
var bow_equip : bool = false
var heal : bool = false
var climbing : bool = false
var dashing : bool = false
var was_hited : bool = false
var hurt_box_excited : bool = false
var dead = false

var direction = Vector2(0,0)

var is_on_wall : bool = false

var checkpoint = null

var life = 100
onready var arrow_cd_timer : Timer = $Timers/ArrowCoolDownTimer
onready var jump_timer : Timer = $Timers/JumpTimer
onready var floor_timer : Timer = $Timers/FloorTimer
onready var ladder_timer : Timer = $Timers/LadderTimer
onready var platform_timer : Timer = $Timers/PlatformTimer
onready var dash_timer : Timer = $Timers/DashTimer
onready var sprite : AnimatedSprite = $AnimatedSprite
onready var body : Node2D = $Body
onready var anim : AnimationPlayer = $AnimatedSprite/AnimationPlayer
onready var state_machine: PlayerFSM = $PlayerStates
onready var tween : Tween = $Tween
onready var waves : Particles2D = $Waves
onready var invecible_timer = $Timers/InvencibleTimer
onready var healing_timer = $Timers/HealingTimer
onready var grounded_sound : AudioStreamPlayer2D = $AnimatedSprite/FloorHit
onready var jump_sound : AudioStreamPlayer2D = $AnimatedSprite/Jump
export onready var scene_name=get_tree().get_current_scene().get_name()

func _ready():
	
	state_machine.init(self)
	
	yield(get_tree(), "idle_frame")
	get_tree().call_group("enemies", "set_player", self)
	get_tree().call_group("checkpoints", "set_player", self)
	get_tree().call_group("HUD", "set_player", self)
	

func _physics_process(delta):
	update_inputs()
	state_machine.run()
	emit_signal("hud", "%s" % state_machine.active_state.tag)

func get_wall():
	if sprite.flip_h: 
		direction = Vector2(1,0)
	else:
		direction = Vector2(-1,0)


func update_inputs():
	
	get_wall()
	is_on_wall=test_move(transform, direction)
	if(Input.is_action_just_pressed("sword")):
		bow_equip = false
	
	if(Input.is_action_just_pressed("bow")):
		if(scene_name!="TreacheryTemplate"):
			bow_equip = true
	
	horizontal = (
		int(Input.is_action_pressed("ui_right"))
		- int(Input.is_action_pressed("ui_left"))
	)
	vertical = (
		int(Input.is_action_pressed("ui_down"))
		- int(Input.is_action_pressed("ui_up"))
	)
	up = Input.is_action_pressed("ui_up")
	if Input.is_action_just_pressed("ui_accept"):
		jump_timer.start()
	if is_on_floor():
		floor_timer.start()
	
	if not hurt_box_excited:
		if(bow_equip==true):
			if Input.is_action_pressed("light_attack"):
				bow_atk=true
			else:
				bow_atk=false
		else:
			if Input.is_action_pressed("light_attack"):
				if(scene_name!="FraudTemplate" && scene_name!="TreacheryTemplate"):
					attacking=true
			elif Input.is_action_pressed("heavy_attack"):
				if(scene_name!="HeresyTemplate" && scene_name!="ViolenceTemplate" && scene_name!="FraudTemplate" && scene_name!="TreacheryTemplate"):
					h_attacking=true
			else:
				h_attacking=false
				attacking=false
	else:
		h_attacking=false
		attacking=false
		bow_atk=false
		
	if(Input.is_action_pressed("heal") && healing_timer.is_stopped() &&(scene_name=="LimboTemplate" || scene_name=="LustTemplate" || scene_name=="GluttonyTemplate" || scene_name=="GreedTemplate")):
		if life < 100:
			heal = true
			life += 20
			healing_timer.start()
	else: 
		heal=false
		
	if(Input.is_action_pressed("climb") && (scene_name=="LimboTemplate" || scene_name=="LustTemplate" || scene_name=="GluttonyTemplate")):
		if is_on_wall:
			climbing=true
	else: 
		climbing=false
		
	if(Input.is_action_just_pressed("dash") && (scene_name=="LimboTemplate" || scene_name=="LustTemplate")):
		dashing = true
	
	if hurt_box_excited :
		was_hited = true
		if invecible_timer.is_stopped():
			life -= 20
			invecible_timer.start()
	else:
		was_hited = false

func move():
	if life > 0:
		var old = velocity
		velocity += forces
		forces = Vector2.ZERO
		velocity = move_and_slide(velocity, Vector2.UP, true)

			
		for i in range(get_slide_count()):
			var collision = get_slide_collision(i)
			if(get_slide_collision(i).collider.get_name().find("Spikes")!= -1):
				self.death()
			
			if collision.collider.has_method("collide_with"):
				
				collision.collider.collide_with(collision,self)
	else:
		self.death()		


func apply_gravity (gravity:float):
	velocity += Vector2.DOWN * gravity

func play(animation:String):
	if anim.current_animation == animation or animation == "air":
		return
	anim.play(animation)

func tween_to_ladder():
	var target = Vector2(ladder_x, position.y)
	tween.interpolate_property(self, "position", position, target,
		0.05, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()

func can_climb():
	return ladder_area and ladder_timer.is_stopped()

func death():
	dead = true
	get_tree().paused = true

func respawn():
	dead = false
	if checkpoint != null:
		checkpoint.reset()
		return
	get_tree().reload_current_scene()

###########################################################
# Setget
###########################################################
func _get_vx():
	return vx
func _set_vx(val:float):
	if val != 0:
		if val > 0:
			body.scale.x = -1
			sprite.flip_h = true
		else:
			body.scale.x = 1
			sprite.flip_h = false
	velocity.x = val
	vx = val

func _get_vy():
	return vy
func _set_vy(val:float):
	velocity.y = val
	vy = val

func _get_grounded():
	grounded = not floor_timer.is_stopped()
	return grounded

#func _get_dashing():
#	dashing = not dash_timer.is_stopped()
#	return dashing

func _get_jumping():
	jumping = not jump_timer.is_stopped()
	return jumping
###########################################################

func _on_PlatformTimer_timeout():
	collision_layer = 1 | 2

func _on_LavaLake_body_entered(body):
	self.death()

func _on_LavaLake2_body_entered(body):
	self.death()

func _on_LavaLake3_body_entered(body):
	self.death()

func _on_HurtArea_area_entered(area):
	if "HitDamage" in area.name:
		hurt_box_excited = true
	else:
		hurt_box_excited = false

func _on_HurtArea_area_exited(area):
	hurt_box_excited = false
