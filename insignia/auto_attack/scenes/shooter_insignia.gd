class_name ShooterInsignia
extends AutoAttackInsignia

var max_distance : float
var projectile_scene : PackedScene

func setup(data : AutoAttackData) -> void:
	super(data)
	var d : ShooterAttackData = data as ShooterAttackData
	max_distance = d.max_distance
	projectile_scene = d.projectile_scene

func _auto_attack() -> bool:
	var target : Enemy = _find_nearest_enemy()
	if not target: return false
	
	var projectile : Projectile = projectile_scene.instantiate()
	projectile.dir = global_position.direction_to(target.global_position)
	projectile.stats_manager = stats_manager
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	return true


func _find_nearest_enemy() -> Enemy:
	var nearest : Enemy = null
	var nearest_dist_sq : float = max_distance*max_distance
	
	for node : Node in get_tree().get_nodes_in_group(Utils.ENEMY_GROUP):
		var enemy : Enemy = node as Enemy
		if not enemy: continue
		var dist_sq : float = global_position.distance_squared_to(enemy.global_position)
		if dist_sq < nearest_dist_sq:
			nearest = enemy
			nearest_dist_sq = dist_sq
	
	return nearest
