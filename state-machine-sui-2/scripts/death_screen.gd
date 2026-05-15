extends CanvasLayer


@export var continue_button: Button
@export var menu_button: Button

@export_file("*tscn") var _menu_scene: String


func _ready() -> void:
	continue_button.pressed.connect(_continue_game)
	menu_button.pressed.connect(_goto_menu)
	

func _continue_game() -> void:
	CharacterController.player.set_godmode(true)
	CharacterController.player.dead = false
	visible = false


func _goto_menu() -> void:
	get_tree().change_scene_to_file(_menu_scene)
