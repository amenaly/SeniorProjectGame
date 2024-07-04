extends Node2D

var sentence_label : RichTextLabel 
var errorlabel2 : Label
var drop_boxes = []

#pop up test 
var display_test : String = "Help Guide:"

func _ready():
#Initialize reference 
	sentence_label = $SentenceLabel
	errorlabel2 = $errorlabel2
	
	drop_boxes = [$InputBox/Panel/Input]
	
func display_PrintError(message: String):
	errorlabel2.text = message
func _on_submit_button_pressed():
	#Get the text from the LineEdit 
	var display_test = $InputBox/Panel/Input.text 
	if display_test == "":
		display_PrintError("Input cannot be empty!")
	else:
		display_PrintError("")
		#print date and time
		#var time = Time.get_time_dict_from_system()
		#print("%02d:%02d:%02d" % [time.hour, time.minute])
		var new_pop_up = preload("res://EndCertificate.tscn").instantiate()
		new_pop_up.display_test = display_test
		add_child(new_pop_up)
