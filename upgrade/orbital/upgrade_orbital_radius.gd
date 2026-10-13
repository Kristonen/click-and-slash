class_name UpgradeOrbitalRadius
extends UpgradeData

@export var amount : float

func apply(player : Player) -> void:
	var insignia : OrbitalAttackInsignia = player.auto_attack_insignia as OrbitalAttackInsignia
	insignia.radius += amount
	insignia.spawn_projectiles()
