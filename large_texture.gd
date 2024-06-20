extends TextureRect

#class_name AnswerBlock #register class name to be called
signal dropped(answers: String)

var original_texture : Texture2D = null
var answers : String = ""

var label : Label

func _ready(): 
	label = $Panel/Label
	original_texture = texture
	label.text = answers
	#print("Initial Answer:", answers) #Debugging
	
func _get_drag_data(at_position):
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(50,50)
	
	var preview_label = Label.new()
	preview_label.text = answers
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	preview.add_child(preview_label)
 
	set_drag_preview(preview)
	texture = null
	label.text = ""
	
	#return preview_texture.texture
	#print("Drag started with answer:", answers) #Debugging
	return answers

func _can_drop_data(_pos, data):
	#return data is Texture2D
	return data is String
 
 #data drop in sentences 
func _drop_data(_pos, data):
	#print("Drop data recieved:", data) #debugging
	if data is String:
		answers = data 
		label.text = data 
		texture = load("") #loads the image to the sentence 
		#texture = original_texture
		emit_signal("dropped", answers)
		print("Dropped answer: ", answers)  # Debugging
	#if data is Texture2D:
		#texture = data
	else:
		texture = original_texture
		#label.text = answers
			
func _gui_input(event):
	#Handle cancellation if system detects an uncompleted drag and drop. Click on button to regen 
	if event is InputEventMouseButton and not event.pressed:
		if texture == null:
			texture = original_texture
			label.text = answers
