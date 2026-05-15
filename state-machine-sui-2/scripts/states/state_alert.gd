class_name StateAlert
extends AgentState


var seeing_player: bool = false

@export var _state_aggro: AgentState
@export var _state_passive: AgentState

@export var time_until_cooldown: float
var _curr_time: float

@export var time_until_aggro: float
var _curr_aggro: float

func react_to_disturb(pos: Vector2) -> void:
	if pos.distance_to(agent.position) <= notice_radius:
		_curr_time = 0
		agent.set_new_nav_point(pos)


func see_player() -> void:
	seeing_player = true


func loose_player() -> void:
	seeing_player = false


func process_override(delta: float) -> void:
	if seeing_player == false:
		_curr_time += delta
		_curr_aggro = max(0, _curr_aggro - delta * 2)
		if _curr_time >= time_until_cooldown:
			state_machine.set_new_state(_state_passive)
	else:
		_curr_time = 0
		_curr_aggro += delta
		if _curr_aggro >= time_until_aggro:
			state_machine.set_new_state(_state_aggro)
	
	if agent.moving == false:
		_idle_cooldown_current -= delta
		if _idle_cooldown_current <= 0:
			var next_point = agent.global_position + Vector2(randf_range(-1000, 1000), randf_range(-1000, 1000))
			next_point = NavigationServer2D.map_get_closest_point(get_viewport().get_world_2d().navigation_map, next_point)
			agent.set_new_nav_point(next_point)
			_idle_cooldown_current = randf_range(0.8, 1.2) * _idle_cooldown_after_reached
		
	agent.detection_bar.value = _curr_aggro / time_until_aggro


func position_reached() -> void:
	agent.moving = false
	

func activate_state() -> void:
	super()
	_curr_time = 0
	_curr_aggro = 0
	seeing_player = false
	if agent.seeing_target == true:
		see_player()
	agent.detection_bar.visible = true
	

func crate_reached(crate: CrateStack) -> void:
	crate.stack_up()
	position_reached()
