extends Node

signal item_collected(item : Item)

var player : Player:
	get:
		var player_node : Player = get_player()
		if player_node:
			return player_node
		else:
			push_error("No player found")
			return null
var game_ui : GameUI

func _ready() -> void:
	item_collected.connect(_on_item_collected)

func _on_item_collected(item : Item) -> void:
	if item is Coin:
		player.coins += item.value

func update_coins() -> void:
	game_ui.update_coins(player)

func get_player() -> Player:
	for node : Node in get_tree().current_scene.get_children():
		if node is Player: return node
	return null
