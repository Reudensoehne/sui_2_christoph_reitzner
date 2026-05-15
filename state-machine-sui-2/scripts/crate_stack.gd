class_name CrateStack
extends StaticBody2D

@export var _space_bar: Sprite2D

@export var _stacked_collision_shape: CollisionShape2D
@export var _pushed_collision_shape: CollisionPolygon2D

@export var _stacked_sprite: Sprite2D
@export var _pushed_sprite: Sprite2D

@export var _area_push: Area2D

var _push_enabled = false
var _pushed = false


func _ready() -> void:
	_area_push.body_entered.connect(area_entered)
	_area_push.body_exited.connect(area_exited)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("push") == true and _push_enabled == true:
		push_over()


## Pushes over the crate stack and alarm agents
func push_over() -> void:
	_stacked_collision_shape.disabled = true
	_stacked_sprite.visible = false
	
	_pushed_collision_shape.disabled = false
	_pushed_sprite.visible = true
	
	AgentManager.instance.disturb_agents(global_position, self)
	_space_bar.visible = false
	_pushed = true


## Stacks the crates back up, resetting its state
func stack_up() -> void:
	_stacked_collision_shape.set_deferred("disabled" , false)
	_stacked_sprite.visible = true
	
	_pushed_collision_shape.set_deferred("disabled" , true)
	_pushed_sprite.visible = false
	
	_pushed = false


## Enables pushing if player gets into interaction area or stacking if
## agent enters interaction area
func area_entered(body: Node2D) -> void:
	if body is CharacterController and _pushed == false:
		_push_enabled = true
		_space_bar.visible = true
	
	if body is Agent:
		body.crate_reached(self)


## Disables interaction if player leaves area
func area_exited(body: Node2D) -> void:
	if body is CharacterController:
		_push_enabled = false
		_space_bar.visible = false
