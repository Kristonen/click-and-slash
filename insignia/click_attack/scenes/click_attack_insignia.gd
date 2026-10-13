@abstract class_name ClickAttackInsignia
extends Insignia

var damage : float
var cooldown_time : float
var _cooldown_left : float = 0.0

func setup(data : ClickAttackData) -> void:
	damage = data.damage
	cooldown_time = data.cooldown
	
func _process(delta: float) -> void:
	_cooldown_left = maxf(_cooldown_left - delta, 0.0)
	
func on_click(pos : Vector2) -> void:
	if _cooldown_left > 0.0: return
	if _click_attack(pos):
		_cooldown_left = cooldown_time
	
@abstract func _click_attack(pos : Vector2) -> bool
