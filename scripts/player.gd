extends Node2D

#создали пользовательский сигнал
signal state_player(state)
var hp = 3

# список именовоных констант
# список состояний игрока
enum State  {
	NORMAL,  #0
	RIGHT,   #1
	LEFT,    #2
	DOWN,    #3
	DEAD     #4
}

var state = State.NORMAL

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("open_up"):
		state = State.NORMAL
		emit_signal("state_player", state)
	if Input.is_action_just_pressed("left"):
		if state == State.NORMAL:
			state = State.LEFT
			emit_signal("state_player", state)
	if Input.is_action_just_pressed("right"):
		if state == State.NORMAL:
			state = State.RIGHT
			emit_signal("state_player", state)
	if Input.is_action_just_pressed("down"):
		if state == State.NORMAL:
			state = State.DOWN
			emit_signal("state_player", state)
	
