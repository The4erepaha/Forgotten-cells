extends Node2D

func _ready() -> void:
	$Start_menu/Guide_menu.visible = false




func _on_start_button_pressed() -> void:   # начать игру
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_guide_button_pressed() -> void:   # переход к гайду
	$Start_menu/Guide_menu.visible = true



func _on_exit_guide_pressed() -> void:   # выход из гайда
	$Start_menu/Guide_menu.visible = false


func _on_exit_game_button_pressed() -> void: # выход из игры
	get_tree().quit()
