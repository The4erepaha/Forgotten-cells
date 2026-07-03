extends Node2D

func _ready() -> void:
	$Guide_panel.visible = false


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_guide_button_pressed() -> void:
	$Guide_panel.visible = true


func _on_exit_button_pressed() -> void:
	$Guide_panel.visible = false
