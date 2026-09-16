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
	while !Utils.check_if_in_viewport(pos):
		var x : float = randf_range(-150, 150)
		var y : float = randf_range(-150, 150)
		pos = global_position + Vector2(x, y)
	wander_pos = pos

func _on_clicked() -> void:
	for i : int in range(randi_range(3, 10)):
		var coin : Coin = coin_scene.instantiate()
		coin.global_position = global_position
		coin.is_collectable = false
		get_tree().current_scene.add_child(coin)
	super()
