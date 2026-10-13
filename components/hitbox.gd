class_name Hitbox
extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area : Area2D) -> void:
	var parent : Node2D = get_parent()
	if parent is not Projectile: return
	if area is Clickable:
		parent = parent as Projectile
		var damage : float = parent.stats_manager.get_damage(parent.base_damage)
		area.hit(0)
