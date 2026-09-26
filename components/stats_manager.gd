class_name StatsManager
extends Node

@export_group("DAMAGE")
@export var base_damage : float
@export var extra_damage_flat : float
@export var extra_damage_percentage : float

@export_group("CRIT-DMG")
@export var base_crit_dmg : float
@export var extra_crit_flat_dmg : float
@export var extra_crit_percentage_dmg : float

@export_group("CRIT-CHANCE")
@export var base_crit_change : float
@export var extra_crit_flat_chance : float

func add_flat_damage(extra : float) -> void:
	extra_damage_flat += extra
	
func add_percentage_damage(extra : float) -> void:
	extra_damage_percentage += extra

func get_damage() -> float:
	return (base_damage + extra_damage_flat) * (1 + extra_damage_percentage)

func get_crit_dmg() -> float:
	return base_damage + base_crit_dmg + extra_crit_flat_dmg * (1 + extra_crit_percentage_dmg)

func get_crit_chance() -> float:
	return base_crit_change + extra_crit_flat_chance
