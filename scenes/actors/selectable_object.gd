extends Area2D

var is_hovered: bool = false

# Todo: Hovered state

func _on_mouse_entered():
	is_hovered = true


func _on_mouse_exited():
	is_hovered = false


func _input(event):
	if event.is_action_pressed('select') and is_hovered:
		clicked()


## Override
func clicked(): 
	print('overide with somethin!')

"""
	Functionality in button
	
	
	Functionality in level
	
"""
