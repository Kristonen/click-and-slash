@abstract class_name AutoAttackInsignia
extends Insignia

var damage : float
var fire_interval : float
var _attack_cd : float

func setup(data : AutoAttackData) -> void:
	damage = data.damage
	fire_interval = data.fire_interval
	
func _process(delta: float) -> void:
	_tick(delta)

func _tick(delta : float) -> void:
	_attack_cd = maxf(_attack_cd - delta, 0.0)
	if _attack_cd > 0.0: return
	
	if _auto_attack():
		_attack_cd = fire_interval

func _auto_attack() -> bool:
	return false
