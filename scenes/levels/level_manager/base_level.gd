extends Node2D
class_name Level

"""
	Dependencies: 
		Types.EnterParams
			* An autoload "Types" node with class "EnterParams" 
"""

var current_line: String = "hello [color=red]sexy ass"
var index: int = 0

signal change_level(level_path: String, enter_params: Types.EnterParams)

@onready var subtitle = $Subtitle



func _ready():
	subtitle.text = current_line


func init(enter_params: Types.EnterParams = null): 
	if enter_params: 
		print("Hey! I have enter params")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		#print(key_typed)
		
		# Typed the correct character. 
		if key_typed == current_line[index]:
			current_line[index+1] = '[/color]'
			subtitle.text = current_line
			print("correct!: " + key_typed)
			
			# Advance to the next character. 
			index = min(index+1, current_line.length()-1)
			
			
		
		
		

