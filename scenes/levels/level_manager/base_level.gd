extends Node2D
class_name Level

"""
	Dependencies: 
		Types.EnterParams
			* An autoload "Types" node with class "EnterParams" 
"""

var current_word: String = "hello"
var index: int = 0

signal change_level(level_path: String, enter_params: Types.EnterParams)

func init(enter_params: Types.EnterParams = null): 
	if enter_params: 
		print("Hey! I have enter params")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		#print(key_typed)
	
		if key_typed == current_word[index]:
			print("correct!: " + key_typed)
			index = min(index+1, current_word.length()-1)
			
			
		
		
		

