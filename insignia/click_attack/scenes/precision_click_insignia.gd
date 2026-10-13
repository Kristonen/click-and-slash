class_name PrecisionClickInsignia
extends ClickAttackInsignia

func _click_attack(pos : Vector2) -> bool:
	var hits : Array[Clickable] = Utils.get_clickables_at(pos)
	if hits.is_empty(): return false
	
	hits[0].hit(stats_manager.get_damage(damage))
	return true
