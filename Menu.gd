extends Control
##Code your Way Home Created by Anerys Menal 
##Summer 2024 CS6395 Dr.Redfield
 
var text_to_show : String = "[b]Help Guide to play the Game:[/b]\nTo Drag and Drop, click on the answer and while holding the mouse down drag over to the correct box.
\nIf the answer disappear, reclick on the empty answer key box to repopulate the answer. For type boxes, type answer. To clear backspace or press the X to clear the text box.
\nOnce done, click Submit and then Next Level to continue.
\n[b]What is PsuedoCode?[/b] 
Informal description of coding algorithms for programming language. Algorithms are a procedure used for solving a problem or performing a computation.
\n[b]List of Commands:[/b] 
Input- User inputs command into the code to be executed. 
Output- Prints out Code
Call- Calls a specific code to be executed 
Function(def function)- Creates a function to be executed within the code
If/Then/Else/EndIf- Test a condition with 2 options or determines if code is executed
For/While- Creats a specialized loop for a specific number of times if conditions are met
"
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
	
