extends Control


@export var start_button: Button
@export var manual_button: Button
@export var quit_button: Button

@export_file("*tscn") var _game_scene: String
@export_file("*tscn") var _manual_scene: String


func _ready() -> void:
	start_button.pressed.connect(_start_game)
	quit_button.pressed.connect(_quit_game)
	manual_button.pressed.connect(_show_manual)
	

func _start_game() -> void:
	get_tree().change_scene_to_file(_game_scene)


func _show_manual() -> void:
	get_tree().change_scene_to_file(_manual_scene)


func _quit_game() -> void:
	get_tree().quit()
