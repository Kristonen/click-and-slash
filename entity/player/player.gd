class_name Player extends Node2D

@export var collector : Collector
@export var detector : Detector
@export var stats_manager : StatsManager

var coins : float

func _ready() -> void:
	if collector:
		collector.collected.connect(_on_collect_item)

func _physics_process(_delta: float) -> void:
	global_position = get_global_mouse_position()

func check_item_launch_finishded(item : Item) -> void:
	for area : Area2D in detector.get_overlapping_areas():
		if item.collectable == area:
			item.following = self

func _on_collect_item(item : Item) -> void:
	if item is Coin:
		var value : float = stats_manager.get_coin_value(item.value)
		coins += value
	Event.item_collected.emit()
