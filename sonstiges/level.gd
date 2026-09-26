class_name Level
extends Node2D

@export var game_ui : GameUI
@export var wave_manager : WaveManager
@export var player : Player

func _ready() -> void:
	wave_manager.wave_prepared.connect(new_wave)
	wave_manager.wave_started.connect(game_ui.start_round)
	wave_manager.start_wave(0)
	
	if game_ui:
		Event.item_collected.connect(_on_item_collected)

func new_wave(wave : WaveData) -> void:
	wave.goal.progress_updated.connect(game_ui.update_goal)
	game_ui.set_new_wave(wave)

func _on_item_collected() -> void:
	if !player: return
	game_ui.update_coins(player.coins)
