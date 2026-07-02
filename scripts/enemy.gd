extends Node2D


signal enemy_atack(damage)

@export var hp_enemy = 1
@export var enemy_damage = 1


func _ready() -> void:
	$Timer.start()    # начало таймера (в инспекторе значение ставить: wait_time)


# функция получения урона от игрока
func take_damage_enemy(damage):
	hp_enemy -= damage
	print(hp_enemy)
	if hp_enemy <= 0:
		die_enemy()


# функция смерти врага
func die_enemy():
	queue_free()         # удаляет узел из сцены в конце кадра



func _on_timer_timeout() -> void:
	print("враг пропал")
	emit_signal("enemy_atack", enemy_damage)
	queue_free()
