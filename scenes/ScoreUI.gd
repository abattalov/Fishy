extends CanvasLayer

@onready var score_container_one: HFlowContainer = $Control/HFlowContainer
@onready var score_container_two: HFlowContainer = $Control/HFlowContainer2
@onready var score_container_three: HFlowContainer = $Control/HFlowContainer3
@onready var score_container_four: HFlowContainer = $Control/HFlowContainer4
@onready var one_tally: PackedScene = preload("res://scenes/one.tscn")
@onready var five_tally: PackedScene = preload("res://scenes/five.tscn")
@onready var twenty_five: PackedScene = preload("res://scenes/twentyfive.tscn")
@onready var one_hundred: PackedScene = preload("res://scenes/onehundred.tscn")

var score: int = 0

func update_score(new_score: int):
	score = new_score
	update_display()

func update_display():
	
	for child in score_container_one.get_children():
		score_container_one.remove_child(child)
		child.queue_free()
		
	for child in score_container_two.get_children():
		score_container_one.remove_child(child)
		child.queue_free()
	
	for child in score_container_three.get_children():
		score_container_three.remove_child(child)
		child.queue_free()
	
	for child in score_container_four.get_children():
		score_container_four.remove_child(child)
		child.queue_free()
	
	var num_hundreds = score / 100
	var remaining_after_hundreds = score % 100
	var num_twenty_fives = remaining_after_hundreds / 25
	var reamining_after_twenty_fives = remaining_after_hundreds % 25
	var num_fives = reamining_after_twenty_fives / 5
	var num_ones = reamining_after_twenty_fives % 5
	
	for i in range(num_hundreds):
		var one_hundred_instance = one_hundred.instantiate()
		score_container_four.add_child(one_hundred_instance)
	
	for i in range(num_twenty_fives):
		var twenty_five_instance = twenty_five.instantiate()
		score_container_three.add_child(twenty_five_instance)
	
	for i in range(num_fives):
		var five_instance = five_tally.instantiate()
		score_container_two.add_child(five_instance)
		
	for i in range(num_ones):
		var one_instance = one_tally.instantiate()
		score_container_one.add_child(one_instance)
		
		
func increment_score(amount: int = 1):
	update_score(score + amount)
