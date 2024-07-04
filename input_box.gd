extends TextureRect

signal dropped(answers: String)
signal get_input(new_text: String) #signal for text change

var original_texture : Texture2D = null
var answers : String = ""

var line_edit: LineEdit

#reference PopUp
var popup: Control 

func _ready(): 
	#label = $Panel/Label
	line_edit = $Panel/Input
	original_texture = texture
	line_edit.text = answers
	
	##connect to signal 
	#line_edit.connect("get_input",Callable(self,"_on_LineEdit_change"))
#
#func _on_LineEdit_change(new_text : String):
	#answers = new_text
	#print("LineEdit Text Changed:", new_text) #debugging
	
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
	line_edit.text = ""
	
	return answers

func _can_drop_data(_pos, data):
	#return data is Texture2D
	return data is String
 
 #data drop in sentences 
func _drop_data(_pos, data):
	#print("Drop data recieved:", data) #debugging
	if data is String:
		answers = data 
		line_edit.text = data 
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
			line_edit.text = answers

func _on_input_text_submitted(new_text):
	print("Change Text:",line_edit.text)
	emit_signal("get_input", line_edit.text)
	#queue_free()
