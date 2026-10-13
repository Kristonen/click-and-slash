@abstract class_name UpgradeData
extends Resource

@export var upgrade_name : String
@export_multiline("Description") var upgrade_desc : String
@export var required : Script

func is_useable(player : Player) -> bool:
	if is_instance_of(player.auto_attack_insignia, required): return true
	if is_instance_of(player.click_attack_insignia, required): return true
	return false

@abstract func apply(player : Player) -> void
