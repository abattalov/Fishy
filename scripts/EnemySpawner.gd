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
	new_enemy.score_ui = $"../ScoreUI"
	
	if new_enemy.name == "EnemyFish6":
		if randf() < 0.2:
			new_enemy.queue_free()
			
	add_child(new_enemy)
	var random_int = randi_range(1,10)
	
	#randomize fish attributes
	new_enemy.enemy_fish.scale *= random_int * 0.2
	new_enemy.detection_area.scale *= random_int * 0.2
	new_enemy.speed *= randi() % 3
	
	var screen_size = get_viewport().get_visible_rect().size
	
	var enemy_sprite = new_enemy.get_node("%EnemyFish")  # Assuming %EnemyFish is the correct path
	var region_size = enemy_sprite.region_rect.size if enemy_sprite.region_enabled else enemy_sprite.texture.get_size()
	
	if randf() < 0.5:
		new_enemy.position = Vector2(-(region_size.x + 200), randf() * screen_size.y)
		new_enemy.face_direction = 1  # Move right
	else:
		new_enemy.position = Vector2(screen_size.x + region_size.x + 200, randf() * screen_size.y)
		new_enemy.face_direction = -1  # Move left
