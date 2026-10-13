class_name AuraInsignia
extends AutoAttackInsignia

var radius : float

func setup(data : AutoAttackData) -> void:
	super(data)
	radius = (data as AuraAttackData).radius
	
func _auto_attack() -> bool:
	var hit_any : bool = false
	for node : Node in get_tree().get_nodes_in_group(Utils.ENEMY_GROUP):
		var enemy : Enemy = node as Enemy
		if not enemy: continue
		if global_position.distance_to(enemy.global_position) <= radius:
			enemy.clickable.hit(stats_manager.get_damage(damage))
			hit_any = true
	return hit_any
