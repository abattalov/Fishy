extends CharacterBody2D

const FRICTION = 300.0
var is_deleted = false
var direction
var face_direction = 1
var score_ui

@export var speed = 200.0

@onready var enemy_fish: Sprite2D = %EnemyFish
@onready var detection_area: Area2D = $Area2D
@onready var fish_collider: CollisionShape2D = $Area2D/CollisionShape2D
@onready var player = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	detection_area.body_entered.connect(_on_area_2d_body_entered)

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
	
	velocity.x = direction.x * speed * face_direction
	velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
	move_and_slide()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if player.is_bigger(self):
			score_ui.increment_score(1)
			player.grow()
			detection_area.body_entered.disconnect(_on_area_2d_body_entered)
			queue_free()
		else:
			player.die()
