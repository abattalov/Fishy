extends CharacterBody2D

const SPEED = 200.0
const FRICTION = 200.0
const GRAVITY = 20.0
const GROWTH = 1.025

var current_score: int = 0

@onready var player_fish = %PlayerFish
@onready var player_sprite: Sprite2D = %PlayerFish
@onready var player_collider: CollisionShape2D = $CollisionShape2D
@onready var game_over_ui: Control = $"../GameOverScreen/GameOverUI"
@onready var win_ui: Control = $"../WinScreen/WinUI"

func is_bigger(enemy: CharacterBody2D) -> bool:
	var enemy_size = enemy.enemy_fish.region_rect.size.x * enemy.enemy_fish.scale.x
	var player_size = player_sprite.region_rect.size.x * player_sprite.scale.x
	
	if player_size > enemy_size:
		return true
	else:
		return false
		

func add_fish_to_score():
	current_score += 1
	print(current_score)
func die():
	queue_free()
	#get_tree().paused = true
	game_over_ui.visible = true

func grow():
	player_sprite.scale *= GROWTH
	player_collider.scale *= GROWTH
	var player_width= player_sprite.region_rect.size.x * player_sprite.scale.x
	var screen_width = get_viewport().get_visible_rect().size.x
	if(player_width > screen_width):
		Engine.time_scale = 0
		win_ui.visible = true
		
	


func _physics_process(delta):
	var screen_size = get_viewport().get_visible_rect().size #1152,648
	
	#wrap around effect
	if position.x > screen_size.x:
		position.x = 0
	elif position.x < 0:
		position.x = screen_size.x
	
	var horizontal_direction = Input.get_axis("ui_left", "ui_right")
	var verticle_direction = Input.get_axis("ui_up", "ui_down")

	if horizontal_direction:
		velocity.x = horizontal_direction * SPEED
		player_fish.flip_h = horizontal_direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
	if verticle_direction:
		velocity.y = verticle_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, FRICTION * delta)
		if velocity.y == 0:
			velocity.y = GRAVITY
		
	move_and_slide()
