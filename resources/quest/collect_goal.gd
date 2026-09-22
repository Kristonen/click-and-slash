class_name CollectGoal
extends QuestGoal

func setup_listeners() -> void:
	Game.item_collected.connect(_on_item_collected)

func cleanup_listeners() -> void:
	Game.item_collected.disconnect(_on_item_collected)

func _on_item_collected(item : Item) -> void:
	add_progress()
