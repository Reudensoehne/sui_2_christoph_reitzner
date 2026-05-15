class_name CharacterController
extends RigidBody2D


static var player: CharacterController
var godmode: bool = false
var speed: float = 20
var dead: bool = false

@export var sprite: Sprite2D


func _physics_process(delta: float) -> void:
	if dead == false:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		translate(input_direction * speed)
	
	if Input.is_action_just_pressed("toggle_godmode") == true:
		set_godmode(!godmode)


func set_godmode(is_godmode: bool) -> void:
	godmode = is_godmode
	if godmode == false:
		sprite.modulate.a = 1
	else:
		sprite.modulate.a = 0.5


func _enter_tree() -> void:
	player = self
