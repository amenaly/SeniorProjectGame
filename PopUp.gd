extends Control

var text_to_show = "This is a popup!"

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect/Panel/Label.text = text_to_show
	
func _on_button_pressed():
	self.hide()
	
#Pass the text from LineEdit User Input, set to main text 
func update_text(new_text: String):
	$TextureRect/Panel/Label.text = new_text
	print("Popup Text Updates to:", new_text)
