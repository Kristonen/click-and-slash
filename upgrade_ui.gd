class_name UpgradeUI
extends Control

@export var avaiable_upgrades : Array[UpgradeData]
@export var upgrade_slots : Array[UpgradeSlot]


func _ready() -> void:
	var upgrade_data : UpgradeData = avaiable_upgrades[0]
	for slot : UpgradeSlot in upgrade_slots:
		slot.set_upgrade(upgrade_data)
		slot.upgrade_applied.connect(_on_applied_upgrade)

func _on_applied_upgrade() -> void:
	get_tree().paused = false
	queue_free()
