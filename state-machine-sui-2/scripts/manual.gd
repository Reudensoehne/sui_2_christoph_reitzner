extends Control

@export var back_button: Button

@export_file("*tscn") var _menu_scene: String


func _ready() -> void:
	back_button.pressed.connect(_to_main_menu)
	

func _to_main_menu() -> void:
	get_tree().change_scene_to_file(_menu_scene)
