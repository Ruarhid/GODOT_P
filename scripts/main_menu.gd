class_name MainMenu
extends  Control

@onready var play_button: Button = %PlayButton
@onready var options_button: Button = %OptionsButton
@onready var about_button: Button = %AboutButton
@onready var exit_button: Button = %ExitButton

const OPTIONS_SCENE: PackedScene = preload("res://scenes/gui/options_menu.tscn")

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	options_button.pressed.connect(_on_options_pressed)
	about_button.pressed.connect(_on_about_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

func _on_play_pressed() -> void:
	print("Start Game")

func _on_options_pressed() -> void:
	var options_instance = OPTIONS_SCENE.instantiate()
	get_tree().root.add_child(options_instance)
	queue_free()

func _on_about_pressed() -> void:
	print("Show About")

func _on_exit_pressed() -> void:
	get_tree().quit()
