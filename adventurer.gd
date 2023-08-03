extends CharacterBody2D

var run_speed = 80.0
var attacks = ["attack1", "attack2"]
# attack sounds
@onready var state_machine = $AnimationTree["parameters/playback"]

func _physics_process(delta):
	var current_anim = state_machine.get_current_node()
	if current_anim in ["hurt", "die"]:
		return
		
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * run_speed
	if Input.is_action_just_pressed("attack"):
		state_machine.travel(attacks.pick_random())
		return
	
	if velocity.x != 0:
		$Sprite2D.scale.x = sign(velocity.x)
	if velocity.length() > 0:
		state_machine.travel("run")
	else:
		state_machine.travel("idle")
	move_and_slide()

func hurt():
	state_machine.travel("hurt")
	
func die():
	state_machine.travel("die")
	set_physics_process(false)

func _on_sword_hit_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
