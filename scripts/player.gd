extends Node2D




#сигнал для ресурсов (hp,ammo,armor)

@export var hp = 3     #hp игрока
@export var ammo = 3        # амуниция игрока
@export var armor = 3       # броня игрока

signal player_state(state)

enum State{
	NORMAL,
	LEFT,
	RIGHT,
	DOWN
}
signal changed_resources()

var state = State.NORMAL

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	leeSystem()

# функция отвечающяя за логику и перемещение между препятствиями.
func leeSystem():
	if Input.is_action_just_pressed("open_up"):  # клавиша W
		state = State.NORMAL
		emit_signal("player_state", state)
	if Input.is_action_just_pressed("left"): 
		if state == State.NORMAL:
			state = State.LEFT
			hp_bonus()
			emit_signal("player_state",state)
			emit_signal("changed_resources")
	if Input.is_action_just_pressed("right"):
		if state == State.NORMAL:
			state = State.RIGHT
			ammo_bonus()
			emit_signal("player_state", state)
			emit_signal("changed_resources")
	if Input.is_action_just_pressed("down"):    # клавиша S
		if state == State.NORMAL:
			state = State.DOWN
			armor_bonus()
			emit_signal("player_state", state)
			emit_signal("changed_resources")


#функция отвечающая за бонус для Hp [+1 hp]
func hp_bonus():
	hp += 1
	print("Add 1 hp")
	if hp >=3:
		hp = 3
		print("Hp is full")

# функция отвечающая за бонус для патронов
func ammo_bonus():
	ammo += 1
	print("Add 1 ammo")
	if ammo >= 3:
		ammo = 3
		print("Magazine is full")

func armor_bonus():
	armor += 1
	print("Add 1 armor")
	if armor >=3:
		armor = 3
		print("Armor is full")
