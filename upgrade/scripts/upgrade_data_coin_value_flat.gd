class_name  UpgradeDataCoinValueFlat
extends UpgradeData

@export var value : float

func apply(player : Player) -> void:
	player.stats_manager.add_flat_coin(value)
