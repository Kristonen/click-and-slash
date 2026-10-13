class_name AoEClickInsignia
extends ClickAttackInsignia

var radius : float

func setup(data : ClickAttackData) -> void:
	super(data)
	radius = (data as AoEClickData).radius

func _click_attack(pos : Vector2) -> bool:
	var hit_any : bool = false
	for node : Node in get_tree().get_nodes_in_group(Utils.ENEMY_GROUP):
		var enemy : Enemy = node as Enemy
		if not enemy: continue
		if pos.distance_to(enemy.global_position) <= radius:
			enemy.clickable.hit(stats_manager.get_damage(damage))
			hit_any = true
	return hit_any
