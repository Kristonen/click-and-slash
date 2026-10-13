class_name Level
extends Node2D

@export var game_ui : GameUI
@export var wave_manager : WaveManager
@export var player : Player
@export var upgrade_ui_scene : PackedScene

var current_coins : float
var count : int = 1

func _ready() -> void:
	Event.item_collected.connect(_on_item_collected)
	if game_ui: wave_manager.wave_started.connect(game_ui.start_round)
	wave_manager.wave_prepared.connect(new_wave)
	wave_manager.start_wave(0)

func new_wave(wave : WaveData) -> void:
	if game_ui:
		wave.goal.progress_updated.connect(game_ui.update_goal)
		game_ui.set_new_wave(wave)

func _on_item_collected(item : Item) -> void:
	if item is Coin:
		current_coins += player.stats_manager.get_coin_value(item.value)
		game_ui.update_coins(current_coins)
		if current_coins > 50 * count * 2:
			get_tree().paused = true
			var upgrade_ui : UpgradeUI = upgrade_ui_scene.instantiate()
			#var size : Vector2 = get_viewport().get_visible_rect().size
			#upgrade_ui.global_position = Vector2(size.x / 2, size.y / 2)
			get_parent().add_child(upgrade_ui)
			count += 1
