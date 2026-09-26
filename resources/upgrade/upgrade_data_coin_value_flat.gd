class_name  UpgradeDataCoinValueFlat
extends UpgradeData

@export var value : float

func apply(stats : StatsManager) -> void:
	stats.add_flat_coin(value)
