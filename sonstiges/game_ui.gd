class_name GameUI
extends CanvasLayer

@export var coins : Label

@export var round_time : Label
@export var round_timer : Timer
@export var wave_number : Label
@export var goal : Label
@export var desc : Label

func _process(_delta: float) -> void:
	if round_time:
		var total_second : int = int(ceilf(round_timer.time_left))
		var minutes : int = total_second / 60
		var seconds : int = total_second % 60
		round_time.text = "%d:%02d" % [minutes, seconds]

func update_coins(value : int) -> void:
	coins.text = str(value)

func start_round(time : float) -> void:
	round_timer.start(time)

func set_new_wave(wave : WaveData) -> void:
	if wave.goal is KillGoal:
		desc.text = "Eliminate %d enemies!" % wave.goal.target_amount
	elif wave.goal is CollectGoal:
		desc.text = "Collect %d coins!" % wave.goal.target_amount
	wave_number.text = "Wave: %d" % wave.wave_number

func update_goal(current : int, target : int) -> void:
	if !goal: return
	goal.text = "%d/%d" % [current, target]
