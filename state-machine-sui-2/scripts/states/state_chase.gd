class_name StateChase
extends AgentState


var seeing_player: bool = false

@export var _state_aggro: AgentState
var _move_speed_bonus = 1


func react_to_disturb(_pos: Vector2) -> void:
	_move_speed_bonus += 0.2
	agent.movespeed = _movespeed * _move_speed_bonus


func see_player() -> void:
	seeing_player = true


func loose_player() -> void:
	seeing_player = false


func process_override(_delta: float) -> void:
	if seeing_player == true:
		agent.set_new_nav_point(CharacterController.player.global_position)


func position_reached() -> void:
	if seeing_player == false:
		_move_speed_bonus = 1
		state_machine.set_new_state(_state_aggro)


func activate_state() -> void:
	super()
	if agent.seeing_target == true:
		see_player()
	_move_speed_bonus = 1
	agent.killing = true

	
func crate_reached(crate: CrateStack) -> void:
	pass
