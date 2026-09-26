class_name UpgradeDataDamageFlat
extends UpgradeData

@export var value : float

func apply(stats : StatsManager) -> void:
	stats.add_flat_damage(value)
	
