extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	#get_tree().change_scene_to_file("res://Level10.tscn")
		unlock_next_level()
		get_tree().change_scene_to_file("res://LevelSelection.tscn")
		
func unlock_next_level():
	var level_selection = preload("res://LevelSelection.tscn").instantiate()
	level_selection.unlocked_levels += 7
	level_selection.save()
