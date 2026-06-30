extends Node2D


@onready var player = $Player



func _ready() -> void:
	player.player_state.connect(_on_state_player)
	player.changed_resources.connect(_update_resources)
	$lee_left.visible = false
	$lee_right.visible = false
	$lee_down.visible = false
	$HUD/HP_bar/HP_label.text = "HP:" + str(player.hp)
	$HUD/Ammo_bar/Ammo_label.text = "Ammo: " +str(player.ammo)
	$HUD/Armor_bar/Armor_label.text = "Armor: " + str(player.armor)


func _physics_process(_delta: float) -> void:
	pass


# функция для состояния игрока и припятствий
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

func _update_resources():
	$HUD/HP_bar/HP_label.text = "HP:" + str(player.hp)
	$HUD/Ammo_bar/Ammo_label.text = "Ammo: " + str(player.ammo)
	$HUD/Armor_bar/Armor_label.text = "Armor: " + str(player.armor)
