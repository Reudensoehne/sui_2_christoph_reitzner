class_name Agent
extends CharacterBody2D


var target_pos: Vector2
@export var nav_agent: NavigationAgent2D

var movespeed = 1000
var moving = false
var crate_to_fix: CrateStack = null
var seeing_target = false
var killing = false

@export var _state_machine: StateMachine
@export var _state_sprite: Sprite2D
@export var _raycast: RayCast2D
@export var _killzone: Area2D

@export var vision_radius_sprite: Sprite2D
@export var notice_radius_sprite: Sprite2D

@export var detection_bar: ProgressBar


func _ready() -> void:
	AgentManager.instance.agents.append(self)
	nav_agent.max_speed = 1000
	nav_agent.target_reached.connect(_state_machine.position_reached)
	_killzone.body_entered.connect(kill_player)


func set_new_nav_point(pos: Vector2):
	nav_agent.target_position = pos
	moving = true
	

func kill_player(body: Node2D):
	if CharacterController.player.godmode == false and killing == true:
		GameManager.instance.kill_player()


func _process(delta: float) -> void:
	var point = _state_machine.current_state.vision_radius * (CharacterController.player.global_position - global_position).normalized()
	_raycast.target_position = point
	
	if ((_raycast.get_collider() is CharacterController and CharacterController.player.godmode == false)
			and seeing_target == false):
		seeing_target = true
		_state_machine.see_player()
	
	if ((_raycast.get_collider() is not CharacterController or CharacterController.player.godmode == true)
			and seeing_target == true):
		seeing_target = false
		_state_machine.unsee_player()
		
	


func disturb_agent(pos: Vector2, crate: CrateStack) -> void:
	_state_machine.react_to_disturb(pos)
	
	if crate != null:
		crate_to_fix = crate


func _physics_process(delta: float) -> void:
	var current_position = global_position
	var next_position = nav_agent.get_next_path_position()
	var movement_direction = (next_position - current_position).normalized()
	
	velocity = movement_direction * movespeed
	
	if moving == true:
		move_and_slide()
	

func crate_reached(crate: CrateStack) -> void:
	if crate == crate_to_fix:
		_state_machine.crate_reached(crate)


func change_vision_radius(radius: float):
	vision_radius_sprite.scale = Vector2(radius, radius) / 250


func change_notice_radius(radius: float):
	notice_radius_sprite.scale = Vector2(radius, radius) / 250
