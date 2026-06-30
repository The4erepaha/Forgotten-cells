extends Node2D


@onready var player = $Player



func _ready() -> void:
	player.player_state.connect(_on_state_player)
	$lee_left.visible = false
	$lee_right.visible = false
	$lee_down.visible = false
	


func _physics_process(_delta: float) -> void:
	pass


func _on_state_player(state):
	if state == 0:
		$lee_left.visible = false
		$lee_right.visible = false
		$lee_down.visible = false
	if state == 1:
		$lee_left.visible = true
		$lee_right.visible = false
		$lee_down.visible = false
	if state == 2:
		$lee_left.visible = false
		$lee_right.visible = true
		$lee_down.visible = false
	if state == 3:
		$lee_left.visible = false
		$lee_right.visible = false
		$lee_down.visible = true
