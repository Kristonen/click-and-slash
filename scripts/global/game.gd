extends Node

signal item_collected(item : Item)

#var player : Player
var game_ui : GameUI

func _ready() -> void:
	item_collected.connect(_on_item_collected)

func _on_item_collected(item : Item) -> void:
	
	if item is Coin:
		get_player().coins += item.value

func update_coins() -> void:
	game_ui.update_coins(get_player())

func get_player() -> Player:
	for node : Node in get_tree().current_scene.get_children():
		if node is Player: return node
	return null
