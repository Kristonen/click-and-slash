class_name UpgradeDataDamagePercentage
extends UpgradeData

@export_range(0.0, 1.0, 0.01) var value : float

func apply(player : Player) -> void:
	player.stats_manager.add_percentage_damage(value)
