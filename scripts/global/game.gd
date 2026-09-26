extends Node

#signal item_collected(item : Item)
#signal enemy_killed(enemy : Enemy)

var level : Level:
	get: return get_tree().current_scene as Level

func _ready() -> void:
	Event.item_collected.connect(_on_item_collected)

func _on_item_collected(item : Item) -> void:
	if item is Coin and level.player:
		level.player.coins += item.value
		level.game_ui.update_coins(level.player.coins)
