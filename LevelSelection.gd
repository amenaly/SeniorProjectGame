extends Control
var unlocked_levels = 1
var level_index : float = 0
var ErrorLabel : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	ErrorLabel = $ErrorLabel
	load_progress()
	connect_buttons()
	update_level_buttons()

func save():
	var save_file = FileAccess.open("user://save_game.save", FileAccess.WRITE)
	save_file.store_32(unlocked_levels)
	save_file.close()
	
func load_progress():
	if FileAccess.file_exists("user://save_game.save"):
		var save_file = FileAccess.open("user://save_game.save", FileAccess.READ)
		unlocked_levels = save_file.get_32()
		save_file.close()
	else:
		unlocked_levels = 1
		
func update_level_buttons():
	for i in range(9):
		var level_button = $LevelContainer.get_node("Level" + str(i + 1))
		#debugging 
		if level_button:
			print("Found button: Level" + str(i + 1))
			level_button.disabled = i >= unlocked_levels
		else:
			print("Button not found: Level" + str(i + 1))
		#$LevelContainer/Level2.disabled = true
	
func connect_buttons():
	for i in range(9):
		var level_button = $LevelContainer.get_node("Level" + str(i + 1))
		if level_button:
			level_button.connect("pressed", Callable(self, "_on_LevelButton_pressed").bind(i + 1))
			
func display_error(message: String):
	ErrorLabel.text = message

func _on_LevelButton_pressed(level_index):
	print("Button pressed for Level:", level_index)
	if level_index <= unlocked_levels:
		print("Loading Level:", level_index)
		get_tree().change_scene_to_file("res://level" + str(level_index) + ".tscn")
	else:
		display_error("This level is locked!")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
