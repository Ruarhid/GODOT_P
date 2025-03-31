# scripts/settings.gd
class_name GameSettings
extends Node

static var instance: GameSettings

# Основные настройки по умолчанию
const DEFAULT_CONFIG: Dictionary = {
	"display": {
		"fullscreen": false,
		"resolution": Vector2i(1280, 720)
	},
	"audio": {
		"master_volume": 1.0,
		"music_volume": 1.0,
		"sfx_volume": 1.0
	},
	"controls": {
		"key_jump": KEY_SPACE,
		"key_move_left": KEY_A,
		"key_move_right": KEY_D
	}
}

# Текущие настройки
var config: Dictionary = DEFAULT_CONFIG.duplicate(true)

# Путь к файлу конфигурации
const CONFIG_PATH: String = "res://settings.cfg"

# Инициализация при загрузке синглтона
func _ready() -> void:
	instance = self
	load_settings()

# Загрузка настроек из файла
func load_settings() -> void:
	var file: ConfigFile = ConfigFile.new()
	var err: Error = file.load(CONFIG_PATH)
	
	if err == OK:
		# Загрузка значений из файла
		for section in DEFAULT_CONFIG.keys():
			for key in DEFAULT_CONFIG[section].keys():
				if file.has_section_key(section, key):
					config[section][key] = file.get_value(section, key)
	#КОСТЫЛЬ!!!
	apply_settings()

# Сохранение настроек в файл
func save_settings() -> void:
	var file: ConfigFile = ConfigFile.new()
	
	# Запись каждой секции и её параметров
	for section in config.keys():
		for key in config[section].keys():
			file.set_value(section, key, config[section][key])
	
	file.save(CONFIG_PATH)

# Сброс настроек к значениям по умолчанию
func reset_to_default() -> void:
	config = DEFAULT_CONFIG.duplicate(true)
	save_settings()
	apply_settings()

# Применение текущих настроек
func apply_settings() -> void:
	# Настройки дисплея
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if config["display"]["fullscreen"] else DisplayServer.WINDOW_MODE_WINDOWED
	)
	DisplayServer.window_set_size(config["display"]["resolution"])
	
	# Настройки звука
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"), 
		linear_to_db(config["audio"]["master_volume"])
	)
	
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"), 
		linear_to_db(config["audio"]["music_volume"])
	)
	
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"), 
		linear_to_db(config["audio"]["sfx_volume"])
	)
	
	print("Master index ", AudioServer.get_bus_index("Master"))
	print("Music index ", AudioServer.get_bus_index("Music"))
	print("SFX index ", AudioServer.get_bus_index("SFX"))
