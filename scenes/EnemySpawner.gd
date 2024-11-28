extends Node2D
@onready var spawn_timer: Timer = $SpawnTimer
@export var enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.start()

func _on_timer_timout() -> void:
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	var screen_size = get_viewport().get_visible_rect().size
	
	if randf() < 0.5:
		new_enemy.position = Vector2(-10.0, randf() * screen_size.y)
		new_enemy.face_direction = 1  # Move right
	else:
		new_enemy.position = Vector2(screen_size.x + 10, randf() * screen_size.y)
		new_enemy.face_direction = -1  # Move left
