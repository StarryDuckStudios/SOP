extends Node2D
const _menu: PackedScene = preload("res://Cenas/menu.tscn")
@onready var _hud: CanvasLayer = $_hud
func _input(event):
	if Input.is_action_just_pressed("x") and _hud.get_child_count() == 0:
		var new_menu = _menu.instantiate()
		_hud.add_child(new_menu)
