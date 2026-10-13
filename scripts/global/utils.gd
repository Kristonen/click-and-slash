extends Node

const PLAYER_GROUP : String = "player"

func check_if_in_viewport(pos : Vector2) -> bool:
	var size : Vector2 = get_viewport().size
	if pos.x > 0 and pos.y > 0 and pos.x < size.x and pos.y < size.y: return true
	return false

func get_player() -> Player:
	return get_tree().get_first_node_in_group(PLAYER_GROUP)
