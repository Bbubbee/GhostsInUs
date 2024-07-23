extends Node2D
class_name Level

"""
	Dependencies: 
		Types.EnterParams
			* An autoload "Types" node with class "EnterParams" 
"""

var text: String = "this is america don't catch me slipping"
var index: int = 0

signal change_level(level_path: String, enter_params: Types.EnterParams)

@onready var subtitle = $Subtitle

@export var blue: Color = Color("#4682b4")
@export var green: Color = Color("#639765")
@export var red: Color = Color("#a65455")



func _ready():
	subtitle.text = text


func init(enter_params: Types.EnterParams = null): 
	if enter_params: 
		print("Hey! I have enter params")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		#print(key_typed)
		
		# Typed the correct character. 
		if key_typed == text[index]:
			# Advance to the next character. 
			index = min(index+1, text.length()-1)
			set_next_char()

# Display correctly typed character
func set_next_char():
	var blue_text = get_bbcode_color_tag(blue) + text.substr(0, index) + get_bbcode_color_tag()
	var green_text = get_bbcode_color_tag(green) + text.substr(index, 1) + get_bbcode_color_tag()
	var red_text = get_bbcode_color_tag(red) + text.substr(index+1, text.length()-1) + get_bbcode_color_tag()
	subtitle.text = blue_text+green_text+red_text
	

func get_bbcode_color_tag(color = null) -> String:
	if color: return "[color=#" + color.to_html(false) + "]" 
	else: return "[/color]"
			
			
		
		
		

