# scripts/options_menu.gd
class_name OptionsMenu
extends Control
# Объявление и инициализация кнопок
@onready var resolution_dropdown: OptionButton = %Resolution
@onready var fullscreen_checkbox: CheckBox = %Fullscreen
@onready var master_volume: HSlider = %MasterVolume
@onready var music_volume: HSlider = %MusicVolume
@onready var sfx_volume: HSlider = %SFXVolume

@onready var save_button: Button = %SaveButton
@onready var reset_button: Button = %ResetButton
@onready var back_button: Button = %BackButton

const RESOLUTIONS: Array[Vector2i] = [
	Vector2i(1280, 720),
	Vector2i(1920, 1080),
	Vector2i(2560, 1440)
]

func _ready() -> void:
	_init_display_settings()
	_init_audio_settings()
	_connect_signals()

func _init_display_settings() -> void:
	fullscreen_checkbox.button_pressed = GameSettings.instance.config["display"]["fullscreen"]
	resolution_dropdown.clear()
	for res in RESOLUTIONS:
		resolution_dropdown.add_item("%dx%d" % [res.x, res.y])
	var current_res: Vector2i = GameSettings.instance.config["display"]["resolution"]
	resolution_dropdown.selected = RESOLUTIONS.find(current_res)

func _init_audio_settings() -> void:
	master_volume.value = GameSettings.instance.config["audio"]["master_volume"]
	music_volume.value = GameSettings.instance.config["audio"]["music_volume"]
	sfx_volume.value = GameSettings.instance.config["audio"]["sfx_volume"]

func _connect_signals() -> void:
	fullscreen_checkbox.toggled.connect(_on_fullscreen_checkbox)
	resolution_dropdown.item_selected.connect(_on_resolution_selected)
	master_volume.value_changed.connect(_on_master_volume_changed)
	music_volume.value_changed.connect(_on_music_volume_changed)
	sfx_volume.value_changed.connect(_on_sfx_volume_changed)
	
	save_button.pressed.connect(_on_save_pressed)
	reset_button.pressed.connect(_on_reset_pressed)
	back_button.pressed.connect(_on_back_pressed)

func _on_fullscreen_checkbox(button_pressed: bool) -> void:
	GameSettings.instance.config["display"]["fullscreen"] = button_pressed

func _on_resolution_selected(index: int) -> void:
	GameSettings.instance.config["display"]["resolution"] = RESOLUTIONS[index]

func _on_master_volume_changed(value: float) -> void:
	GameSettings.instance.config["audio"]["master_volume"] = value

func _on_music_volume_changed(value: float) -> void:
	GameSettings.instance.config["audio"]["music_volume"] = value

func _on_sfx_volume_changed(value: float) -> void:
	GameSettings.instance.config["audio"]["sfx_volume"] = value

func _on_save_pressed() -> void:
	GameSettings.instance.save_settings()
	GameSettings.instance.apply_settings()

func _on_reset_pressed() -> void:
	GameSettings.instance.reset_to_default()
	_init_display_settings()
	_init_audio_settings()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
