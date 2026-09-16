extends Popup


var nextLevel
@onready var label: Label = $Coins/CoinsNum/Label

#var achievement: AchievementsClient.Achievement
var waiting := false
var firstPopup = true


func _on_next_level_pressed() -> void:
	_save_game()
	get_tree().change_scene_to_file(nextLevel)
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	_save_game()
	get_tree().change_scene_to_file("res://Menus/menu_main.tscn")
	pass # Replace with function body.


func _on_restart_pressed() -> void:
	_save_game()
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_about_to_popup() -> void:
	if firstPopup:
		nextLevel = "res://Levels/level_" + str(GameManager.currentLevel + 1) + ".tscn"
		label.text = str(GameManager.currentCoins)
		#_check_achivements()
		#_achievement_connect_signals()
		firstPopup = false
	
	if GameManager.highestLevelReached < GameManager.currentLevel:
		GameManager.highestLevelReached = GameManager.currentLevel


func _save_game():
	GameSave._save_data()
