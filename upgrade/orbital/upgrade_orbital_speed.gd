class_name UpgradeOrbitalSpeed
extends UpgradeData

@export var speed : float

func apply(player : Player) -> void:
	var insignia : OrbitalAttackInsignia = player.auto_attack_insignia as OrbitalAttackInsignia
	insignia.speed += speed
	insignia.spawn_projectiles()
	
