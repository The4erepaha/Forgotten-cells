extends Node2D

# ДЛЯ ОБНОВЛЕНИЯ ХУДА ИСПОЛЬЗОВАТЬ emit_signal


#сигнал для ресурсов (hp,ammo,armor)

@export var hp = 3     #hp игрока
@export var ammo = 3        # амуниция игрока
@export var aim_charge = 5     # заряд прицела

@export var player_damage = 1

@export var move_energy = 5  # заряд движения
var move = move_energy
var score_kills = 0   # очки кол-во убитых врагов 

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
	move_aim(_delta)
	if state == State.DOWN:
		aim_bonus(_delta)
	move_system(_delta)


# функция отвечающяя за логику и перемещение между препятствиями.
func leeSystem():
	if Input.is_action_just_pressed("open_up"):  # клавиша W
		state = State.NORMAL
		emit_signal("player_state", state)
	if Input.is_action_just_pressed("left"): 
		if state == State.NORMAL && move == move_energy:
			state = State.LEFT
			hp_bonus()                 # функция хп бонуса
			
			emit_signal("player_state",state)
			emit_signal("changed_resources")
	if Input.is_action_just_pressed("right"):
		if state == State.NORMAL && move == move_energy:
			state = State.RIGHT
			ammo_bonus()              # функция бонуса патронов
			emit_signal("player_state", state)
			emit_signal("changed_resources")
	if Input.is_action_just_pressed("down"):    # клавиша S
		if state == State.NORMAL && move == move_energy:
			state = State.DOWN
			#aim_bonus()              # функция зарядки снайпера 
			emit_signal("player_state", state)
			emit_signal("changed_resources")

# функция отвечающая за логику прицела и выстрела
func move_aim(delta):
	if state == State.NORMAL && aim_charge > 0:
		if Input.is_action_pressed("up_aim"):
			$Gun_idle.visible = false
			$Aim.visible = true
			#спрайт будет менять позицию как и движения мышки (следит за мышкой)
			aim_system(delta)
			$Aim.global_position = get_global_mouse_position()  
			if Input.is_action_just_pressed("shoot"):
				shoot_system()
		else:
			$Aim.visible = false
			$Gun_idle.visible = true
	else: 
		$Aim.visible = false
		$Gun_idle.visible = true



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

# функция отвечающая за систему выстрела 
func shoot_system():
	if ammo >= 1:
		ammo -= 1
		# !!! очень важно, если есть изменние нужен emit_signal 
		# что бы изменилось - нужно  крикнуть
		var overlapping = $Aim.get_overlapping_areas() #это список Area2D которые касаются прицела
		if overlapping.size() > 0:
			var hit_area = overlapping[0]  # hit_area - это Area2D врага
			var enemy = hit_area.get_parent() # enemy это сам узел сцены Enemy (Node2D)
			enemy.take_damage_enemy(player_damage)
			score_kills += 1
		emit_signal("changed_resources")  
	else: print("нет патронов!")


# функция пополнения патронов
func aim_bonus(delta):
	aim_charge += 1 * delta
	if aim_charge >= 5:
		aim_charge = 5
	emit_signal("changed_resources")

# функция пополнения зарядки прицела
func aim_system(delta):
	aim_charge -= 1 * delta
	emit_signal("changed_resources")

# функция получения урона
func take_damage_player(damage):
	hp -= damage
	emit_signal("changed_resources")
	if hp <= 0:
		hp = 0
		die_player()

func move_system(delta):
	if move >= move_energy:
		move = move_energy
	if state == State.NORMAL && move < move_energy:
		move += 1 * delta
	if state != State.NORMAL && move == move_energy:
		move = 0
	emit_signal("changed_resources")


# функция смерти игрока
func die_player():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")   # при смерти возращает в меню
