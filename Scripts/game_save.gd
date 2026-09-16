extends Node

#-------------------------------------------------------------------------------
#--Back
#--Deck Clubs
#--Deck Diamonds
#--Deck Hearts
#--Deck Spades
#--Highest Level Reached
#--Total Coins Held
#--Unlocked Assets
#--Purchased Assets
#--
#-------------------------------------------------------------------------------

const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
const SECURITY_KEY = "1UxG)KIl7l1LdMUZeu?G"

const FILE_NAME_GPS = "CardMatchGameSaveTesting"
const SAVE_NAME = "testSave0"
const SAVE_DESCRIPTION = "Description for testSave0"

var path = SAVE_DIR + SAVE_FILE_NAME
var jsonString


func _ready() -> void:
	_verify_save_directory(SAVE_DIR)
	#_load_save()


func _verify_save_directory(dir) ->void:
	DirAccess.make_dir_absolute(dir)
	pass


func _save_data() -> void:
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_KEY)
	if file == null:
		print(FileAccess.get_open_error())
		return
	
	var data = {
		"clubs": GameManager.clubs,
		"diamonds": GameManager.diamonds,
		"hearts": GameManager.hearts,
		"spades": GameManager.spades,
		"back": GameManager.back,
		"highestLevelReached": GameManager.highestLevelReached,
		"coins": GameManager.totalCoins,
		"purchasedAssets": GameManager.purchasedAssets,
		"unlockedAssets": GameManager.unlockedAssets,
	}
	
	jsonString = JSON.stringify(data, "\t")
	file.store_string(jsonString)
	file.close()
	
	#SnapshotsClient.save_game(FILE_NAME_GPS, "Save file for the game Card Match", jsonString.to_utf8_buffer())
	#
	#SnapshotsClient.game_saved.connect(
		#func (isSaved: bool, saveDataName: String, saveDataDescription: String):
			#if isSaved and saveDataName == SAVE_FILE_NAME and saveDataDescription == jsonString:
				#pass
	#)
	pass


func _save_data_to_gps(play_games_snapshots_client):
	play_games_snapshots_client.save_game(
		GameSave.SAVE_NAME,
		GameSave.SAVE_DESCRIPTION,
		GameSave.jsonString.to_utf8_buffer()
	)
	
	pass

func _load_save() -> void:
	if FileAccess.file_exists(path):
		var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_KEY)
		if file == null:
			print(FileAccess.get_open_error())
			return
		
		var content = file.get_as_text()
		file.close()
		
		var data  = JSON.parse_string(content)
		if data == null:
			printerr("Cannot parse %s as a json string: (%s)"%[path, content])
			return
		
		_assign_in_game_manager(data)

	else:
		printerr("Cannot open non-existant file at %s"%[path])



func _assign_in_game_manager(data) -> void:
	if data.back:
		GameManager.back = data.back
	if data.clubs:
		GameManager.clubs = data.clubs
	if data.diamonds:
		GameManager.diamonds = data.diamonds
	if data.hearts:
		GameManager.hearts = data.hearts
	if data.spades:
		GameManager.spades = data.spades
	if data.highestLevelReached:
		GameManager.highestLevelReached = data.highestLevelReached
	if data.coins:
		GameManager.totalCoins = data.coins
	if data.unlockedAssets:
		GameManager.unlockedAssets = data.unlockedAssets
	if data.purchasedAssets:
		GameManager.purchasedAssets = data.purchasedAssets
