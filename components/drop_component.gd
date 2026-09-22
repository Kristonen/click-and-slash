class_name DropComponent
extends Node

@export var item_scene : PackedScene
@export var min_amount : int
@export var max_amount : int
@export var drop_on_it : bool
@export var clickable : Clickable
@export var health_component : HealthComponent

func _ready() -> void:
	if drop_on_it && clickable:
		clickable.clicked.connect(_on_clicked)
		
	if health_component && not drop_on_it:
		health_component.died.connect(_on_died)

func _on_clicked(data : ClickData) -> void:
	if !data: return
	drop(data.pos)

func _on_died() -> void:
	var parent_node : Node2D = get_parent() as Node2D
	if !parent_node:
		drop(parent_node.global_position)

func drop(pos : Vector2) -> void:
	
	if !item_scene:
		push_error("No item scene for drop component")
		return
		
	
	var amount : int = randi_range(min_amount, max_amount)
	for i : int in range(amount):
		var item : Item = item_scene.instantiate()
		if !item: return
		item.global_position = pos
		get_tree().current_scene.add_child(item)
		
