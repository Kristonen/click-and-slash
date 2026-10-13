class_name UpgradeOrbitalAmount
extends UpgradeData

@export var amount : int

func apply(player : Player) -> void:
	var insignia : OrbitalAttackInsignia = player.auto_attack_insignia as OrbitalAttackInsignia
	insignia.amount += amount
	insignia.spawn_projectiles()
	
