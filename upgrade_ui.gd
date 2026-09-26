class_name UpgradeUI
extends Control

@export var avaiable_upgrades : Array[UpgradeData]
@export var upgrade_slots : Array[UpgradeSlot]


func _ready() -> void:
	for slot : UpgradeSlot in upgrade_slots:
		var random_number : int = randi_range(0, avaiable_upgrades.size() - 1)
		var data : UpgradeData = avaiable_upgrades[random_number]
		slot.set_upgrade(data)
		slot.upgrade_applied.connect(_on_applied_upgrade)

func _on_applied_upgrade() -> void:
	get_tree().paused = false
	queue_free()
