class_name Level
extends Node2D

@export var game_ui : GameUI
@export var wave_manager : WaveManager

func _ready() -> void:
	wave_manager.wave_started.connect(game_ui.start_round)
	wave_manager.start_wave(0)
