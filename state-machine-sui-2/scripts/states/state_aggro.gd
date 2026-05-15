class_name StateAggro
extends AgentState


@export var _chase_state: AgentState
@export var _alert_state: AgentState

@export var time_until_cooldown: float
var _curr_time: float


func react_to_disturb(pos: Vector2) -> void:
	if pos.distance_to(agent.position) <= notice_radius:
		agent.nav_agent.target_position = pos
		agent.movespeed = _movespeed * 2


func see_player() -> void:
	state_machine.set_new_state(_chase_state)


func loose_player() -> void:
	# Not necessary
	pass


func process_override(delta: float) -> void:
	_curr_time += delta
	if _curr_time >= time_until_cooldown:
		state_machine.set_new_state(_alert_state)
	
	if agent.moving == false:
		_idle_cooldown_current -= delta
		if _idle_cooldown_current <= 0:
			var next_point = agent.global_position + Vector2(randf_range(-700, 700), randf_range(-700, 700))
			next_point = NavigationServer2D.map_get_closest_point(get_viewport().get_world_2d().navigation_map, next_point)
			agent.set_new_nav_point(next_point)
			_idle_cooldown_current = randf_range(0.8, 1.2) * _idle_cooldown_after_reached
	

func position_reached() -> void:
	agent.moving = false
	


func activate_state() -> void:
	super()
	_curr_time = 0
	agent.moving = false
	if agent.seeing_target == true:
		see_player()


func crate_reached(crate: CrateStack) -> void:
	position_reached()
