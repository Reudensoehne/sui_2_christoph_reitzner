@abstract
class_name AgentState
extends Node
## This is an abstract class inheritable by the different agent states.
## Depending on implementation the mechanics of the functions can be changed.


## Variables for each state, changing basic behaviour
@export var notice_radius = -1
@export var vision_radius = -1
@export var _movespeed = -1
@export var _idle_cooldown_after_reached: float = 1

## Texture shown as state above the agent
@export var _texture: Texture2D

@export var state_machine: StateMachine
@export var agent: Agent

var _idle_cooldown_current: float


## Called when a crate is pushed, giving the position of the pushed crate
@abstract
func react_to_disturb(pos: Vector2) -> void


## Called when the agent is visible and inside the vision_radius
@abstract
func see_player() -> void


## Called when the player is not visible or leaves vision_radius
@abstract
func loose_player() -> void


## Called every frame inside the _process function inside AgentStateMachine
@abstract
func process_override(delta: float) -> void


## Called when the given NavAgent position has been reached
@abstract
func position_reached() -> void


## Called when stepping inside interaction area of the crate that disturbed the agent
@abstract
func crate_reached(crate: CrateStack) -> void


## Called when state is activated to reset the state
func activate_state() -> void:
	set_state_on_sprite()
	agent.movespeed = _movespeed
	agent.change_notice_radius(notice_radius)
	agent.change_vision_radius(vision_radius)
	_idle_cooldown_current = _idle_cooldown_after_reached
	agent.detection_bar.visible = false
	agent.killing = false


## Called to change state sprite above agent
func set_state_on_sprite() -> void:
	if _texture != null:
		agent._state_sprite.visible = true
		agent._state_sprite.texture = _texture
	else:
		agent._state_sprite.visible = false
