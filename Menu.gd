extends Control
var text_to_show : String = "Help Guide:\nTo Drag and Drop, click on the answer and while holding the mouse down drag over to the correct box.
\nIf the answer disappear, reclick on the empty answer key box to repopulate the answer. For type boxes, type answer. To clear backspace or press the X to clear the text box.
\nOnce done, click Submit and then Next Level to continue."

#control with mouse 
func _ready():
	$VBoxContainer/PLayer.grab_focus()
	
func _on_p_layer_pressed():
	get_tree().change_scene_to_file("res://LevelSelection.tscn")
	
func _on_option_pressed():
	var new_pop_up = preload("res://PopUp.tscn").instantiate()
	new_pop_up.text_to_show = text_to_show
	add_child(new_pop_up)
	
	# Set the position
	new_pop_up.set_position(Vector2(-300,50)) 

func _on_exit_pressed():
	get_tree().quit()
	
