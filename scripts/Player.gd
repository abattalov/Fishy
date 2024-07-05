extends CharacterBody2D

const SPEED = 200.0
const FRICTION = 300.0
const GRAVITY = 20.0

@onready var player_fish = %PlayerFish
	
func _physics_process(delta):
	
	var horizontal_direction = Input.get_axis("ui_left", "ui_right")
	var verticle_direction = Input.get_axis("ui_up", "ui_down")
	

	if horizontal_direction:
		velocity.x = horizontal_direction * SPEED
		player_fish.flip_h = horizontal_direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
	if verticle_direction:
		velocity.y = verticle_direction * SPEED
	elif verticle_direction == 0:
		velocity.y = GRAVITY
	else:
		velocity.y = move_toward(velocity.y, 0, FRICTION * delta)
		
	

	move_and_slide()
	
	
