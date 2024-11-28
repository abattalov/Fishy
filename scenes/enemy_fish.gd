extends CharacterBody2D

const SPEED = 200.0
const FRICTION = 300.0
var is_deleted = false
var direction
var face_direction = 1

@onready var enemy_fish: Sprite2D = %EnemyFish

func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	if randf() < 0.5:
		print("moving right")
		position = Vector2(-10.0, randf() * screen_size.y)
		face_direction = 1
	else:
		print("moving left")
		position = Vector2(screen_size.x + 10, randf() * screen_size.y)
		face_direction = -1
	

func _physics_process(delta):
	var screen_size = get_viewport().get_visible_rect().size	
	var direction = Vector2(1.0,0.0)
	print(position)
	
	if !is_deleted:
		if face_direction == 1 and position.x > screen_size.x:
			is_deleted = true
			queue_free()
		elif face_direction == -1 and position.x < 0:
			is_deleted = true
			queue_free()
	
	velocity.x = direction.x * SPEED * face_direction
	velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
	move_and_slide()
	
	
