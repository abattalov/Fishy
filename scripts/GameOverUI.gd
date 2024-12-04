extends Control

func _on_retry_pressed() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()
