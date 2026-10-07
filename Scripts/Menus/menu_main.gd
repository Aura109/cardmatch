extends Node2D

@onready var menu_settings: Popup = $Popups/MenuSettings
@onready var menu_deck: Popup = $Popups/menuDeck
@onready var background: TextureRect = $Background


var maxSigninRetries = 5


func _enter_tree() -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(GameManager.latestLevel)
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	menu_settings.popup_centered()
	pass # Replace with function body.


func _on_help_pressed() -> void:
	pass # Replace with function body.


func _on_deck_pressed() -> void:
	menu_deck.popup_centered()
	pass # Replace with function body.


func _ready() -> void:
	background.texture = load(GameManager.background)
	
	GameSave._load_save()
