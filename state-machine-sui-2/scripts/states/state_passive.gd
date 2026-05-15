class_name StatePassive
extends AgentState


@export var _state_alert: AgentState
@export var _state_sleep: AgentState

@export var time_until_nap: float
var _curr_time: float


func react_to_disturb(pos: Vector2) -> void:
	if pos.distance_to(agent.position) <= notice_radius:
		agent.set_new_nav_point(pos)
		state_machine.set_new_state(_state_alert)


func see_player() -> void:
	pass


func loose_player() -> void:
	pass


func process_override(delta: float) -> void:
	_curr_time += delta
	if _curr_time >= time_until_nap:
		state_machine.set_new_state(_state_sleep)
	
	if agent.moving == false:
		_idle_cooldown_current -= delta
		if _idle_cooldown_current <= 0:
			var next_point = Vector2(randf_range(-5000, 5000), randf_range(-5000, 5000))
			next_point = NavigationServer2D.map_get_closest_point(get_viewport().get_world_2d().navigation_map, next_point)
			agent.set_new_nav_point(next_point)
			_idle_cooldown_current = randf_range(0.8, 1.2) * _idle_cooldown_after_reached


func position_reached() -> void:
	agent.moving = false


func activate_state() -> void:
	super()
	_curr_time = 0
	

func crate_reached(crate: CrateStack) -> void:
	crate.stack_up()
	position_reached()
