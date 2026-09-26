@abstract class_name UpgradeData
extends Resource

@export var upgrade_name : String
@export_multiline("Description") var upgrade_desc : String

@abstract func apply(stats : StatsManager) -> void
