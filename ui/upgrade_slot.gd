class_name UpgradeSlot
extends PanelContainer

signal upgrade_applied

var upgrade : UpgradeData

@export var apply_btn : Button
@export var upgrade_name : Label
@export var upgrade_desc : Label

func _ready() -> void:
	apply_btn.pressed.connect(_on_apply_upgrade)

func set_upgrade(upgrade_data : UpgradeData) -> void:
	upgrade = upgrade_data
	upgrade_name.text = upgrade.upgrade_name
	upgrade_desc.text = upgrade.upgrade_desc

func _on_apply_upgrade() -> void:
	var player : Player = Utils.get_player()
	upgrade.apply(player)
	upgrade_applied.emit()
