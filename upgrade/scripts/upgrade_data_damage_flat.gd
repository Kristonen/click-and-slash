class_name UpgradeDataDamageFlat
extends UpgradeData

@export var value : float

func apply(player : Player) -> void:
	player.stats_manager.add_flat_damage(value)
	
