extends Node2D
#Level 3

var questions = []
var current_question_index : float = 0

var sentence = ""
var answers = [] 
var answer_labels = []

var errorlabel : Label
var errorlabel2 : Label
var sentence_label : Label 
var drop_boxes = []
#popup
var text_to_show : String = "Help Guide:\nTo read values from a user, we can use the GET function with the format specifiers.
\nint for an integer -> use %d or %i to print or read in
double for a numbers with decimals -> use %lf to print or read in 
char for a character (letters, digits, and others) -> use %c to print or read in 

\nExample: GET(%d, Varaible1). 
\nTo print the values we use the PRINT function with the format specifiers.
\nExample: print(The integer is: %d, variableName1)"

func _ready():
#Initialize reference 
	sentence_label = $SentenceLabel1
	errorlabel = $errorlabel
	errorlabel2 = $errorlabel2
	
	#read to JSON file
	load_level_data("res://JsonFiles/Question3.json")
	load_question(0) #Call function
	
	# Initialize drop boxes
	drop_boxes = [$Input1/Panel/Input, $Text2/Panel/Label, $Text3/Panel/Label]
	
	
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
	 
##WIP testing pop up help guide!!!
func help_guide(): 
	var new_pop_up = preload("res://PopUp.tscn").instantiate()
	new_pop_up.text_to_show = text_to_show
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
		Vector2(1220, 483),
		Vector2(1220, 616),
		Vector2(1220, 759)
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

func display_error(message: String):
	errorlabel.text = message

func display_PrintError(message: String):
	errorlabel2.text = message
	
func _on_submit_button_pressed():
	check_answers()

func _on_next_level_2_pressed():
	#read the index, to see if user has completeled all questions before moving on
	if current_question_index >= questions.size():
		get_tree().change_scene_to_file("res://Level4.tscn")
	else:
		display_error("Complete all questions before moving to the next level.")

func _on_print_button_pressed():
	#Get the text from the LineEdit 
	var text_to_show = {
		"int": $Input1/Panel/Input.text,
		"float": $InputBox/Panel/Input.text, 
		"char": $InputBox2/Panel/Input.text
		}
	
	var has_empty_input = false
	for key in text_to_show.keys():
		if text_to_show[key] == "":
			has_empty_input = true
			break
	if has_empty_input:
		display_PrintError("Input cannot be empty!")
	else:
		display_PrintError("")
		var new_pop_up = preload("res://PopUp.tscn").instantiate()
		var text_to_display = ""
		#Process each inputbox
		for key in text_to_show.keys():
			match key:
				"int":
					if text_to_show[key].is_valid_int():
						text_to_display += "Integer input: " + str(text_to_show[key].to_int()) + "\n"
					else:
						text_to_display += "Invalid integer input!\n"
				"float":
					if text_to_show[key].is_valid_float():
						text_to_display += "Float input: " + str(text_to_show[key].to_float()) + "\n"
					else:
						text_to_display += "Invalid float input!\n"
				"char":
					if text_to_show[key].length():
						text_to_display += "Char input: " + text_to_show[key] + "\n"
					else:
						text_to_display += "Invalid char input!\n"

		new_pop_up.text_to_show = text_to_display
		add_child(new_pop_up)

func _on_help_button_pressed():
	help_guide()
