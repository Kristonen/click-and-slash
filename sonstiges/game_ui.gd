class_name GameUI
extends CanvasLayer

@export var coins : Label
@export var round_time : Label
@export var round_timer : Timer

func _ready() -> void:
	Game.game_ui = self

func _process(_delta: float) -> void:
	if round_time:
		var total_second : int = int(ceilf(round_timer.time_left))
		var minutes : int = total_second / 60
		var seconds : int = total_second % 60
		round_time.text = "%d:%02d" % [minutes, seconds]

func update_coins(player : Player) -> void:
	coins.text = str(player.coins)

func start_round(time : float) -> void:
	round_timer.start(time)
