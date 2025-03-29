# scripts/main_menu.gd
class_name MainMenu
extends Control
# Объявление и инициализация кнопок
@onready var play_button: Button = %PlayButton as Button
@onready var options_button: Button = %OptionsButton as Button
@onready var about_button: Button = %AboutButton as  Button
@onready var exit_button: Button = %ExitButton as Button

# Путь к сценам
const OPTIONS_SCENE: String = "res://scenes/ui/options_menu.tscn"
const ABOUT_SCENE: String = "res://scenes/about.tscn"
const GAME_SCENE: String = "res://scenes/level.tscn"

# Фоновое изображение
@onready var background: TextureRect = $Background

func _ready() -> void:
	# Подключение сигналов кнопок
	play_button.pressed.connect(_on_play_pressed)
	options_button.pressed.connect(_on_options_pressed)
	about_button.pressed.connect(_on_about_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	# Загрузка фонового изображения
	background.texture = load("res://assets/gradient_pixel_art_style_sgzvbqi6m3wekqz4kdj6_2.png")

# Обработка нажатий кнопок
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE)

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file(OPTIONS_SCENE)

func _on_about_pressed() -> void:
	get_tree().change_scene_to_file(ABOUT_SCENE)

func _on_exit_pressed() -> void:
	get_tree().quit()
