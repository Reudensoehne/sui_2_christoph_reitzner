class_name AgentManager
extends Node2D

static var instance: AgentManager
var agents: Array[Agent] = []


func _enter_tree() -> void:
	instance = self


func disturb_agents(pos: Vector2, crate: CrateStack):
	for agent: Agent in agents:
		agent.disturb_agent(pos, crate)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_visual"):
		for agent: Agent in agents:
			agent.vision_radius_sprite.visible = !agent.vision_radius_sprite.visible
	
	if Input.is_action_just_pressed("toggle_notice"):
		for agent: Agent in agents:
			agent.notice_radius_sprite.visible = !agent.notice_radius_sprite.visible
