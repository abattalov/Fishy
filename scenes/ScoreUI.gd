extends CanvasLayer

@onready var score_container: HFlowContainer = $Control/HFlowContainer
@onready var one_tally: PackedScene = preload("res://scenes/one.tscn")
@onready var five_tally: PackedScene = preload("res://scenes/five.tscn")

var score: int = 0

func update_score(new_score: int):
	score = new_score
	update_display()

func update_display():
	print("Updating display: score = ", score)
	print("Num fives = ", score / 5, " Num ones =", score % 5)
	
	for child in score_container.get_children():
		score_container.remove_child(child)
		child.queue_free()
	
	var num_fives = score / 5
	var num_ones = score % 5
	
	for i in range(num_fives):
		var five_instance = five_tally.instantiate()
		score_container.add_child(five_instance)
		print("Added five tally:", five_instance)
		
	for i in range(num_ones):
		var one_instance = one_tally.instantiate()
		score_container.add_child(one_instance)
		print("Added one tally:", one_instance)
		
		
func increment_score(amount: int = 1):
	update_score(score + amount)
