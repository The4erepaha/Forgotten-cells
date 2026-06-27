extends Node2D


@onready var player = $Player

func _ready() -> void:
	#подключаем сигнал из сцены игрока
	player.state_player.connect(_on_player_state_changed) 
	$lee_left.visible = false
	$lee_right.visible = false
	$lee_down.visible = false


func _physics_process(_delta: float) -> void:
	pass


func _on_player_state_changed(state):
	if state == 0: #normal
		$lee_left.visible = false
		$lee_right.visible = false
		$lee_down.visible = false
	if state == 1:  # right
		$lee_right.visible = true
		$lee_left.visible = false
		$lee_down.visible = false
		
	if state == 2:   # left
		$lee_left.visible = true
		$lee_right.visible = false
		$lee_down.visible = false
	if state == 3: #down
		$lee_down.visible = true
		$lee_left.visible = false
		$lee_right.visible = false
