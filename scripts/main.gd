extends Node2D


@onready var player = $Player

@onready var spawn_points = $spawn_zones

const  enemy_scene = preload("res://scenes/enemy.tscn")  #загрузка сцены в память заранее



func _ready() -> void:
	player.player_state.connect(_on_state_player)
	player.changed_resources.connect(_update_resources)
	$lee_items/lee_left.visible = false
	$lee_items/lee_right.visible = false
	$lee_items/lee_down.visible = false
	$HUD/HP_bar/HP_label.text = "HP:" + str(player.hp)
	$HUD/Ammo_bar/Ammo_label.text = "Ammo: " +str(player.ammo)
	$HUD/AimCharge_bar/AimCharge_label.text = "Aim: " + str(player.aim_charge)


func _physics_process(_delta: float) -> void:
	pass


# функция для состояния игрока и припятствий
func _on_state_player(state):
	if state == 0:
		$lee_items/lee_left.visible = false
		$lee_items/lee_right.visible = false
		$lee_items/lee_down.visible = false
	if state == 1:
		$lee_items/lee_left.visible = true
		$lee_items/lee_right.visible = false
		$lee_items/lee_down.visible = false
	if state == 2:
		$lee_items/lee_left.visible = false
		$lee_items/lee_right.visible = true
		$lee_items/lee_down.visible = false
	if state == 3:
		$lee_items/lee_left.visible = false
		$lee_items/lee_right.visible = false
		$lee_items/lee_down.visible = true

func _update_resources():
	$HUD/HP_bar/HP_label.text = "HP:" + str(player.hp)
	$HUD/Ammo_bar/Ammo_label.text = "Ammo: " + str(player.ammo)
	$HUD/AimCharge_bar/AimCharge_label.text = "Aim: " + str(int(player.aim_charge)) 
	$HUD/Score/Score_label.text = "Score: " + str(player.score_kills)
	$HUD/Move_charge/Move_Label.text = "Energy: " + str(int(player.move_energy))


# функция отвечающая за спавн врага
func _on_timer_timeout() -> void:
	if player.state == 0:
		print("враг появился")
		var enemy = enemy_scene.instantiate()  # создание копии сцены
		add_child(enemy)  # добавляем в дерево сцены 
		var points = spawn_points.get_children()   # получаем списки дочерних узлов из узла
		var random_spawn = points.pick_random()    # выбирает рандомный элемент из массива
		enemy.global_position = random_spawn.global_position  # перемещает в рандомный выбраный элемент
		enemy.enemy_atack.connect(_on_enemy_atack)

# функция атаки врага
func _on_enemy_atack(damage):
	if player.state == 0:
		player.take_damage_player(damage)
