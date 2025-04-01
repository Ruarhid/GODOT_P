extends CharacterBody2D

const SPEED = 50.0
var last_direction = Vector2.DOWN  # По умолчанию вниз
@onready var anime = $AnimatedSprite2D

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * SPEED 
	# Обновляем last_direction, если есть движение
	if input_direction != Vector2.ZERO:
		last_direction = input_direction

func _physics_process(_delta: float) -> void:
	get_input()
	update_animation(velocity)
	move_and_slide()

func update_animation(direction: Vector2):
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			if direction.x < 0:
				anime.flip_h = true
				anime.play("run_flip")
			elif direction.x > 0:
				anime.flip_h = false
				anime.play("run_flip")
		else:
			anime.play("run_front" if direction.y > 0 else "run_back")
	else:
		if abs(last_direction.x) > abs(last_direction.y):
			if last_direction.x < 0:
				anime.flip_h = true
				anime.play("idle_flip")
			elif last_direction.x > 0:
				anime.flip_h = false
				anime.play("idle_flip")
		else:
			anime.play("idle_front" if last_direction.y > 0 else "idle_back")
