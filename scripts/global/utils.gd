extends Node

func check_if_in_viewport(pos : Vector2) -> bool:
	var size : Vector2 = get_viewport().size
	if pos.x > 0 and pos.y > 0 and pos.x < size.x and pos.y < size.y: return true
	return false
