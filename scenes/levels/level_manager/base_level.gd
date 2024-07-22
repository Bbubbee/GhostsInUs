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

@export var blue: Color = Color("#4682b4")
@export var green: Color = Color("#639765")
@export var red: Color = Color("#a65455")



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
			print("correct!: " + key_typed)
			
			# Advance to the next character. 
			index = min(index+1, current_line.length()-1)
			set_next_char(1)

func set_next_char(next_char_index: int):
	var blue_text = get_bbcode_color_tag(blue) + current_line.substr(0, next_char_index) + get_bbcode_color_tag()
	print(blue_text) 


func get_bbcode_color_tag(color = null) -> String:
	if color: return "[color=#" + color.to_html(false) + "]" 
	else: return "[/color]"
			
			
		
		
		

