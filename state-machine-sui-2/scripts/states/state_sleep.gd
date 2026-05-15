class_name StateSleep
extends AgentState

@export var _state_dizzy: AgentState
@export var _state_passive: AgentState

@export var time_until_wakeup: float
var _curr_time: float


func react_to_disturb(pos: Vector2) -> void:
	state_machine.set_new_state(_state_dizzy)


func see_player() -> void:
	pass


func loose_player() -> void:
	pass


func process_override(delta: float) -> void:
	_curr_time += delta
	if _curr_time >= time_until_wakeup:
		state_machine.set_new_state(_state_passive)


func position_reached() -> void:
	#set new position
	pass


func activate_state() -> void:
	super()
	_curr_time = 0


func crate_reached(crate: CrateStack) -> void:
	pass
