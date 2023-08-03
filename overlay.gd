extends Node2D

@export var player : CharacterBody2D

var tracked_objects = []

@onready var camera = player.get_node("Camera2D")

func add_object(object):
	if object not in tracked_objects:
		tracked_objects.append(object)
	
func remove_object(object):
	if object in tracked_objects:
		tracked_objects.erase(object)
	
func _process(delta):
	queue_redraw()
	
			
#func _input(event):
#	if event.is_action_pressed("ui_focus_next"):
#		var p = get_node("/root/TileMap/Adventurer/Camera2D").get_screen_center_position()
#		var v = get_viewport_rect().size
#		var r = Rect2(p - v/2, v)
#		print(r)
#		for obj in tracked_objects:
#	#		if obj.get_node("VisibleOnScreenNotifier2D").is_on_screen():
#			if r.has_point(obj.position):
#				prints(obj.name, "is on screen")
#				pass
#			else:
#	#			var pos = (obj.position - p)
#				prints(obj.name, "is off screen")

func _draw():
	var camera_pos = camera.get_screen_center_position()
	var viewport_size = get_viewport_rect().size * 1 / camera.zoom.x  # cam zoom
	var screen_rect = Rect2(camera_pos - viewport_size/2, viewport_size).grow(-2)
#	draw_rect(r, Color.DARK_ORANGE, false)
	for obj in tracked_objects:
#		if not r.has_point(obj.position):
			var pos = obj.position.clamp(screen_rect.position, screen_rect.end)
			if !obj.get_node("VisibleOnScreenNotifier2D").is_on_screen():
				draw_texture(obj.icon, pos - Vector2.ONE*8)
#			draw_line(pos, pos + pos.direction_to(player.position) * 10, Color.CORAL, 1.0)
