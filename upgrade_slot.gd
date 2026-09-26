class_name UpgradeSlot
extends PanelContainer

signal upgrade_applied

var upgrade : UpgradeData

@export var apply_btn : Button
@export var upgrade_name : Label
@export var upgrade_desc : Label

func _ready() -> void:
	if apply_btn:
		apply_btn.pressed.connect(_on_apply_upgrade)
		
	if upgrade:
		upgrade_name.text = upgrade.upgrade_name
		upgrade_desc.text = upgrade.upgrade_desc

func set_upgrade(upgrade_data : UpgradeData) -> void:
	upgrade = upgrade_data
	upgrade_name.text = upgrade.upgrade_name
	upgrade_desc.text = upgrade.upgrade_desc

func _on_apply_upgrade() -> void:
	if upgrade:
		var stats : StatsManager = Game.level.player.stats_manager
		upgrade.apply(stats)
		upgrade_applied.emit()
