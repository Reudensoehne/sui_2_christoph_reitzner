class_name GameManager
extends Node2D

static var instance: GameManager

@export var deathscreen: CanvasLayer


func _enter_tree() -> void:
	instance = self


func kill_player() -> void:
	if CharacterController.player.dead == false:
		deathscreen.visible = true
		CharacterController.player.dead = true


func _process(delta: float) -> void:
	pass
