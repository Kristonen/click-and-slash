class_name UpgradeUI
extends Control

@export var avaiable_upgrades : Array[UpgradeData]
@export var upgrade_slots : Array[UpgradeSlot]

func _ready() -> void:
	var i : int = 0
	var player : Player = Utils.get_player()
	while(i < upgrade_slots.size()):
		var slot : UpgradeSlot = upgrade_slots[i]
		var data : UpgradeData = avaiable_upgrades.pick_random()
		if not data.is_useable(player): continue
		slot.set_upgrade(data)
		slot.upgrade_applied.connect(_on_applied_upgrade)
		i += 1

func _on_applied_upgrade() -> void:
	get_tree().paused = false
	queue_free()
