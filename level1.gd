extends Node2D 
#Level 1

var questions = []
var current_question_index : float = 0

var sentence = ""
var answers = [] 
var answer_labels = []

var errorlabel : Label
var sentence_label : Label 
var drop_boxes = []

#pop up test 
var text_to_show : String = "[b]Help Guide:[/b]\nTo Drag and Drop, click on the answer and while holding the mouse down drag over to the correct box.
\nIf the answer disappear, reclick on the empty answer key box to repopulate the answer. 
\nOnce done, click Submit and then Next Level to continue."


func _ready():
#Initialize reference 
	sentence_label = $SentenceLabel1
	errorlabel = $errorlabel
	
	#read to JSON file
	load_level_data("res://Lvl1Questions.json")
	load_question(0) #Call function
	
	# Initialize drop boxes
	drop_boxes = [$TextLvl1/Panel/Label, $TextLvl2/Panel/Label, $TextLvl3/Panel/Label]
	
	#Load from JSON file
func load_level_data(file_path: String):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content_as_text = file.get_as_text()
	var content_as_dictionary = JSON.parse_string(content_as_text)
	questions = content_as_dictionary["questions"]
	#answers = content_as_dictionary["answers"]
	print("Loaded Anwsers:", answers) #debugging
	return content_as_dictionary
	file.close()	

#Incrementation function if all questions are solve in JSON ends
func load_question(index: int):
	if index >= questions.size():
		print("All questions completed!")
		return
		
	#clear out previous error message when next question loads 
	display_error("")
	
	var question = questions[index]
	sentence = question["sentence"]
	answers = question["answers"]
	
	update_sentence()
	create_answer_blocks()
	

func help_guide(): 
	var new_pop_up = preload("res://PopUp.tscn").instantiate()
	new_pop_up.text_to_show = text_to_show
	add_child(new_pop_up)
	
func help_guide2(): 
	var new_pop_up = preload("res://PopUp.tscn").instantiate()
	var help_text = "[b]List of Commands:[/b] 
Input- User inputs command into the code to be executed. 
Output- Prints out Code
Call- Calls a specific code to be executed 
Function(def function)- Creates a function to be executed within the code
If/Then/Else/EndIf- Test a condition with 2 options or determines if code is executed
For/While- Creats a specialized loop for a specific number of times if conditions are met"
	new_pop_up.text_to_show = help_text
	add_child(new_pop_up)
	
	#Display Sentence from JSON to scene
func update_sentence():
	var display_sentence = sentence.replace("    ", "               ")
	sentence_label.text = display_sentence
	
func create_answer_blocks():
	clear_previous_blocks() #Call Function
	clear_drop_boxes()
	#Set poisition for answer key blocks
	var positions = [
		Vector2(1230, 483),
		Vector2(1230, 616),
		Vector2(1230, 759)
	]
	for i in range(answers.size()):
		create_answer_block(i, positions[i])
		
	#Clear out the answer key blocks 	
func clear_previous_blocks():
	for block in answer_labels:
		block.queue_free()
	answer_labels.clear()
	#Preload blocks to answer key with answers from JSON file
func create_answer_block(index: int, position: Vector2):
	var answer_block = preload("res://texture_rect.tscn").instantiate() 
	answer_block.name = "AnswerBlock"   # Set a unique name for the AnswerBlock
	answer_block.texture = load("")  # Replace with the path to your texture
	answer_block.answers = answers[index]  # Set the answer text
	
	#set position 
	answer_block.position = position
	add_child(answer_block)
	print("Answer block created with answer:", answers[index])  # Debugging

#clear text drop box
func clear_drop_boxes():
	for drop_box in drop_boxes:
		if drop_box.has_method("set_text"):
			drop_box.text = ""
		if drop_box.has_method("set_texture"):
			drop_box.texture = null  # Clear texture if any

func _on_answer_block_dropped(dropped_answer: String, target_drop_box):
	if target_drop_box.has_method("set_text"):
		target_drop_box.text = dropped_answer
	check_answers()

	#Checks that all answers are display then increments to next question
func check_answers(): 
	var all_correct = true
	for i in range(answers.size()):
		if answers[i] != answers[i]:
			all_correct = false
			break
	if all_correct:
		print("Correct!")
		#increments up 1
		current_question_index += 1
		load_question(current_question_index)
	else:
		print("Incorrect! Try Again!")

func _on_next_level_2_pressed():
	#read the index, to see if user has completeled all questions before moving on
	if current_question_index >= questions.size():
		get_tree().change_scene_to_file("res://Level1_2.tscn")
	else:
		display_error("Complete all questions before moving to the next level.")
	
func display_error(message: String):
	errorlabel.text = message

func _on_submit_button_pressed():
	check_answers() # Call Check Function

func _on_help_button_pressed():
	help_guide()

func _on_help_button_2_pressed():
	help_guide2()
