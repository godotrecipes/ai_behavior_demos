extends CharacterBody2D

@export var patrol_path : Path2D
@export var icon: Texture

var run_speed = 25.0
var attacks = ["attack1", "attack2"]

enum states {PATROL, CHASE, ATTACK, DEAD}
var state = states.PATROL
var target = null
var player = null
var current_patrol_point = 0
var patrol_points = []

@onready var anim_state = $AnimationTree["parameters/playback"]

func _ready():
	if patrol_path:
		patrol_points = patrol_path.curve.get_baked_points()

func _physics_process(delta):
	$Label.text = str(states.keys()[state])
	velocity = Vector2.ZERO
	choose_action()
	if target:
		if target.x > position.x:
			$Sprite2D.scale.x = 1
		elif target.x < position.x:
			$Sprite2D.scale.x = -1
		if state != states.ATTACK:
			velocity = position.direction_to(target) * run_speed
		
	if velocity.length() > 0:
		anim_state.travel("run")
	move_and_slide()

func choose_action():
	var current_anim = anim_state.get_current_node()
	if current_anim in attacks:
		return
	match state:
		states.DEAD:
			set_physics_process(false)
		states.PATROL:
			if !patrol_path:
				anim_state.travel("idle")
				target = null
				return
			target = patrol_points[current_patrol_point]
			if position.distance_to(target) < 5:
				current_patrol_point = wrapi(current_patrol_point + 1, 0, patrol_points.size())
		states.CHASE:
			target = player.position
		states.ATTACK:
			target = player.position
			anim_state.travel(attacks.pick_random())

func _on_detect_radius_body_entered(body):
	player = body
	state = states.CHASE

func _on_attack_radius_body_entered(body):
	state = states.ATTACK

func _on_detect_radius_body_exited(body):
	player = null
	state = states.PATROL

func _on_attack_radius_body_exited(body):
	state = states.CHASE
