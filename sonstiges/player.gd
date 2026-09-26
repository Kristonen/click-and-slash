class_name Player extends Node2D

@onready var collector: Collector = $Collector
@onready var detector: Detector = $Detector
@onready var stats_manager: StatsManager = $StatsManager


var coins : int:
	set(value):
		coins = value

func _physics_process(_delta: float) -> void:
	global_position = get_global_mouse_position()

func check_item_launch_finishded(item : Item) -> void:
	for area : Area2D in detector.get_overlapping_areas():
		if item.collectable == area:
			item.following = self
