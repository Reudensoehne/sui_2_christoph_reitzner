class_name StateMachine
extends Node


@export var current_state: AgentState


func _ready() -> void:
	current_state.activate_state()


func _process(delta: float) -> void:
	current_state.process_override(delta)
	
	
func see_player() -> void:
	current_state.see_player()


func unsee_player() -> void:
	current_state.loose_player()


func position_reached() -> void:
	current_state.position_reached()


func react_to_disturb(point: Vector2) -> void:
	current_state.react_to_disturb(point)


func set_new_state(p_new_state: AgentState):
	current_state = p_new_state
	current_state.activate_state()
	

func crate_reached(crate: CrateStack) -> void:
	current_state.crate_reached(crate)
