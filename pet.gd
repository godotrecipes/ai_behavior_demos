extends CharacterBody2D

@export var parent : CharacterBody2D

var speed = 25

@onready var follow_point = parent.get_node("Sprite2D/FollowPoint")

func _physics_process(delta):
	var target = follow_point.global_position
	velocity = Vector2.ZERO
	if position.distance_to(target) > 5:
		velocity = position.direction_to(target) * speed
		
	if velocity.x != 0:
		$Sprite2D.scale.x = sign(velocity.x)
	
	if velocity.length() > 0:
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.play("idle")
		
	move_and_slide()
