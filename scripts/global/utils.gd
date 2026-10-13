extends Node

const PLAYER_GROUP : String = "player"
const ENEMY_GROUP : String = "enemy"

func check_if_in_viewport(pos : Vector2) -> bool:
	var size : Vector2 = get_viewport().size
	if pos.x > 0 and pos.y > 0 and pos.x < size.x and pos.y < size.y: return true
	return false

func get_player() -> Player:
	return get_tree().get_first_node_in_group(PLAYER_GROUP)

func get_clickables_at(point : Vector2) -> Array[Clickable]:
	var query : PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	query.position = point
	query.collide_with_areas = true
	query.collide_with_bodies = false
	
	var results : Array[Dictionary] = get_viewport().world_2d.direct_space_state.intersect_point(query)
	var clickables : Array[Clickable] = []
	for result : Dictionary in results:
		var clickable : Clickable = result.collider as Clickable
		if clickable:
			clickables.append(clickable)
	clickables.sort_custom(_is_above)
	return clickables

func _is_above(a : Clickable, b : Clickable) -> bool:
	var node_a : Node2D = a.get_parent() as Node2D
	var node_b : Node2D = b.get_parent() as Node2D
	if node_a.z_index != node_b.z_index:
		return node_a.z_index > node_b.z_index
	return node_a.get_index() > node_b.get_index()
