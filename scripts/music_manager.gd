extends Node

func _ready():
	$BackgroundMusic.play()
	
func _input(event):
	# Проверяем, был ли клик левой кнопкой мыши
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Проигрываем звук
		$ClickSound.play()
