extends Node2D

var display_test = "Test Name"
var current_time = Time.get_time_string_from_system()
var current_date = Time.get_date_string_from_system()

# Called when the node enters the scene tree for the first time.
func _ready():
	$NameLabel.text = display_test
	$DateInsertLabel.text = current_date
	$TimeInsertLabel.text = current_time
	
func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
	
#Pass the text from LineEdit User Input, set to main text 
func update_text(new_text: String):
	$NameLabel.text = new_text
	$DateInsertLabel.text = current_date
	$TimeInsertLabel.text = current_time
	print("Popup Text Updates to:", new_text)
