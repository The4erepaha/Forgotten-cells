extends Node2D




#сигнал для ресурсов (hp,ammo,armor)

var hp = 3     #hp игрока
var ammo = 3        # амуниция игрока
var armor = 3       # броня игрока

signal player_state(state)

enum State{
	NORMAL,
	LEFT,
	RIGHT,
	DOWN
}

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
			emit_signal("player_state",state)
	if Input.is_action_just_pressed("right"):
		if state == State.NORMAL:
			state = State.RIGHT
			emit_signal("player_state", state)
	if Input.is_action_just_pressed("down"):    # клавиша S
		if state == State.NORMAL:
			state = State.DOWN
			emit_signal("player_state", state)
	

func take_damage():
	hp -= 1
	if hp < 0:
		hp = 0
	
	#emit_signal("hp_changed")
	
	if hp == 0:
		die()


func die():
	print("game over")


func _on_button_pressed() -> void:
	take_damage()
