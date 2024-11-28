extends Node2D
@onready var spawn_timer: Timer = $SpawnTimer
@export var enemy_scenes: Array[PackedScene] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.start()

func _on_timer_timout() -> void:
	
	if enemy_scenes.size() == 0:
		return
	var random_index = randi() % enemy_scenes.size()
	var enemy_scene = enemy_scenes[random_index]
	
	var new_enemy: CharacterBody2D = enemy_scene.instantiate()
	add_child(new_enemy)
	var screen_size = get_viewport().get_visible_rect().size
	
	if randf() < 0.5:
		new_enemy.position = Vector2(-10.0, randf() * screen_size.y)
		new_enemy.face_direction = 1  # Move right
	else:
		new_enemy.position = Vector2(screen_size.x + 10, randf() * screen_size.y)
		new_enemy.face_direction = -1  # Move left
