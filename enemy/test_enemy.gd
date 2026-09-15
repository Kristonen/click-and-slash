class_name TestEnemy
extends Enemy

@export var coin_scene : PackedScene

func _ready() -> void:
	super()
	get_random_wander_pos()
	add_to_group("Enemies")

func _physics_process(delta: float) -> void:
	if global_position.distance_to(wander_pos) < 5:
		get_random_wander_pos()
	var dir : Vector2 = (wander_pos - global_position).normalized()
	velocity = dir * speed * delta
	move_and_slide()

func get_random_wander_pos() -> void:
	var pos : Vector2 = Vector2(-500, -500)
	while !check_if_in_viewport(pos):
		var x : float = randf_range(-150, 150)
		var y : float = randf_range(-150, 150)
		pos = global_position + Vector2(x, y)
	wander_pos = pos

func check_if_in_viewport(pos : Vector2) -> bool:
	var size : Vector2 = get_viewport().size
	if pos.x > 0 and pos.y > 0 and pos.x < size.x and pos.y < size.y: return true
	return false

func _on_clicked() -> void:
	var coin : Node2D = coin_scene.instantiate()
	coin.global_position = global_position
	get_tree().current_scene.add_child(coin)
	super()
