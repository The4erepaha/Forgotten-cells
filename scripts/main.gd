extends Node2D


@onready var player = $Player



func _ready() -> void:
	player.player_state.connect(_on_state_player)
	player.changed_resources.connect(_update_resources)
	$lee_items/lee_left.visible = false
	$lee_items/lee_right.visible = false
	$lee_items/lee_down.visible = false
	$HUD/HP_bar/HP_label.text = "HP:" + str(player.hp)
	$HUD/Ammo_bar/Ammo_label.text = "Ammo: " +str(player.ammo)
	$HUD/AimCharge_bar/AimCharge_label.text = "Armor: " + str(player.aim_charge)


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
