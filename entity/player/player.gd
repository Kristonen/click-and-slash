class_name Player
extends Node2D

@export var collector : Collector
@export var detector : Detector
@export var stats_manager : StatsManager

@export var auto_attack_data : AutoAttackData
@export var click_attack_data : ClickAttackData
@export var click_handler : ClickHandler

var auto_attack_insignia : AutoAttackInsignia
var click_attack_insignia : ClickAttackInsignia

func _ready() -> void:
	collector.collected.connect(_on_collect_item)
	equip_auto_attack_insignia(auto_attack_data)
	equip_click_insignia(click_attack_data)

func _physics_process(_delta: float) -> void:
	global_position = get_global_mouse_position()

func check_item_launch_finishded(item : Item) -> void:
	for area : Area2D in detector.get_overlapping_areas():
		if item.collectable == area:
			item.following = self

func _on_collect_item(item : Item) -> void:
	Event.item_collected.emit(item)

func equip_auto_attack_insignia(data : AutoAttackData) -> void:
	if auto_attack_insignia:
		auto_attack_insignia.queue_free()
		
	var insignia : AutoAttackInsignia = data.scene.instantiate() as AutoAttackInsignia
	assert(insignia != null, "Die Szene von %s hat kein AutoAttackInsignia-Script" % data.display_name)
	
	insignia.stats_manager = stats_manager
	insignia.setup(data)
	add_child(insignia)
	auto_attack_insignia = insignia
	
func equip_click_insignia(data : ClickAttackData) -> void:
	if click_attack_insignia:
		click_attack_insignia.queue_free()
		
	var insignia : ClickAttackInsignia = data.scene.instantiate() as ClickAttackInsignia
	assert(insignia != null, "Die Szene von %s hat kein ClickAttackInsignia-Script" % data.display_name)
	
	insignia.stats_manager = stats_manager
	insignia.setup(data)
	add_child(insignia)
	click_handler.clicked.connect(insignia.on_click)
	click_attack_insignia = insignia
