extends TileMap

func _ready():
	$CanvasLayer/Overlay.add_object($Chest)
	$CanvasLayer/Overlay.add_object($Minotaur)
