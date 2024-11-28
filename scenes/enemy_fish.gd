extends CharacterBody2D

const SPEED = 200.0
const FRICTION = 300.0
var is_deleted = false
var direction
var face_direction = 1

@onready var enemy_fish: Sprite2D = %EnemyFish

func _physics_process(delta):
	
	if face_direction < 0:
		enemy_fish.flip_h = true
		
	var screen_size = get_viewport().get_visible_rect().size	
	direction = Vector2(1.0,0.0)
	
	if !is_deleted:
		if face_direction == 1 and position.x > screen_size.x + 200:
			is_deleted = true
			queue_free()
		elif face_direction == -1 and position.x < -200:
			is_deleted = true
			queue_free()
	
	velocity.x = direction.x * SPEED * face_direction
	velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
	move_and_slide()
	
	
