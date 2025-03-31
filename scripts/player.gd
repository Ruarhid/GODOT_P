extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0


func _physics_process(_delta: float) -> void:

	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = false
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = true

	var directionx:= Input.get_axis("ui_left", "ui_right")
	var directiony:= Input.get_axis("ui_up", "ui_down")
	if directionx or directiony:
		velocity.x = directionx * SPEED
		velocity.y = directiony * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

# Анимация
	if velocity.y > 0:  # Движение вверх
		$AnimatedSprite2D.play("run_front")
	elif velocity.y < 0:  # Движение вниз
		$AnimatedSprite2D.play("run_back")
	elif velocity.x != 0:  # Движение влево или вправо
		$AnimatedSprite2D.play("run_flip")  # Обычная анимация бега
		


	move_and_slide()
