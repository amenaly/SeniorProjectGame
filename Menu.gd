extends Control

#control with mouse 
func _ready():
	$VBoxContainer/PLayer.grab_focus()
	
func _on_p_layer_pressed():
	get_tree().change_scene_to_file("res://level1.tscn")


func _on_option_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
	
