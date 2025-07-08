extends Area2D

var path: Array = []
var path_index := 0
@export var speed := 100.0

@export var fire_rate = 1.0
@export var bullet_scene: PackedScene
var cooldown = 0.0

func _process(delta):
	move_along_path(delta)
	check_for_targets(delta)

func move_along_path(delta):
	if path.size() == 0 or path_index >= path.size():
		return

	var target_pos = path[path_index]
	var direction = (target_pos - global_position).normalized()
	global_position += direction * speed * delta

	if global_position.distance_to(target_pos) < 5:
		path_index += 1
		if path_index >= path.size():
			queue_free()  # opcional: destruir al final del camino

func check_for_targets(delta):
	cooldown -= delta
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") and cooldown <= 0:
			shoot(body)
			cooldown = fire_rate
			break

func shoot(target):
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.target = target
	get_tree().current_scene.add_child(bullet)
