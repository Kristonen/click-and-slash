class_name KillGoal
extends QuestGoal

@export var specific_enemy_type : Script

func setup_listeners() -> void:
	Event.enemy_killed.connect(on_enemy_killed)
	
func cleanup_listeners() -> void:
	Event.enemy_killed.disconnect(on_enemy_killed)

func on_enemy_killed(enemy : Node) -> void:
	if is_completed: return
	
	if !specific_enemy_type or specific_enemy_type == enemy.get_script():
		add_progress()
