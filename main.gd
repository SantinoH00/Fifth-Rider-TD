extends Node2D

@export var enemy_scene: PackedScene
var path = [Vector2(100, 100), Vector2(300, 100), Vector2(300, 300)]

func _ready():
	spawn_enemy()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.path = path
	enemy.global_position = path[0]
	enemy.add_to_group("enemies")
	add_child(enemy)
