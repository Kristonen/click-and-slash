class_name GameUI
extends CanvasLayer

@onready var coins: Label = $Control/MarginContainer/HBoxContainer/Coins

func _ready() -> void:
	Game.game_ui = self

func update_coins(player : Player) -> void:
	coins.text = str(player.coins)
