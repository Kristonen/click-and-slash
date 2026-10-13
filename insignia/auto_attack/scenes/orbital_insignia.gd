class_name OrbitalAttackInsignia
extends AutoAttackInsignia

var projectile_scene : PackedScene
var radius : float
var amount : int
var speed : float
var pivot : Node2D

func setup(data : AutoAttackData) -> void:
	super(data)
	var d : OrbitalAttackData = data as OrbitalAttackData
	projectile_scene = d.projectil_scene
	radius = d.radius
	amount = d.amount
	speed = d.speed
	spawn_projectiles()

func _tick(delta : float) -> void:
	pivot.global_position = pivot.get_global_mouse_position()
	pivot.rotation = wrapf(pivot.rotation + speed * delta, 0.0, TAU)

func spawn_projectiles() -> void:
	if pivot:
		for node : Node in pivot.get_children(): node.queue_free()
		pivot.queue_free()
		
	pivot = Node2D.new()
	add_child(pivot)
	for i : int in range(amount):
		var projectile : Projectile = projectile_scene.instantiate()
		projectile.stats_manager = stats_manager
		projectile.base_damage = damage
		projectile.position = Vector2.from_angle(TAU / amount * i) * radius
		print("amount=", amount, " radius=", radius, " i=", i, " pos=", projectile.position)
		pivot.add_child(projectile)
	
