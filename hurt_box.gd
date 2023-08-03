extends Area2D

signal hp_changed

@export var hp = 3

@onready var parent = get_parent()

func take_damage(amount):
	hp -= amount
	hp_changed.emit(hp)
	if hp > 0:
		parent.hurt()
	else:
		$CollisionShape2D.set_deferred("disabled", true)
		parent.die()
