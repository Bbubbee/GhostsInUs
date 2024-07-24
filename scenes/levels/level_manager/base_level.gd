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
@export var white: Color = Color("#639765")
@export var red: Color = Color("#a65455")


func _ready():
	set_subtitle()


func init(enter_params: Types.EnterParams = null): 
	if enter_params: 
		print("Hey! I have enter params")


func _unhandled_input(event: InputEvent) -> void:
	# Enter character. 
	if event is InputEventKey and event.is_pressed():
		# Get simplified character that was typed. 
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		
		# Typed the correct character. 
		if key_typed == text[index]:
			# Advance to the next character. 
			index = min(index+1, text.length()-1)
			set_subtitle()
	
	# Delete character.
	if event.is_action_pressed("delete"):
		index = min(index-1, text.length()-1)
		set_subtitle()


# Display new subtitle.
func set_subtitle():
	# Correct chars. 
	var blue_text = get_bbcode_color_tag(blue) + text.substr(0, index) + get_bbcode_color_tag()
	# Current char. 
	var green_text = get_bbcode_color_tag(white) + text.substr(index, 1) + get_bbcode_color_tag()
	# Chars left to type.  
	var red_text = get_bbcode_color_tag(white) + text.substr(index+1, text.length()-1) + get_bbcode_color_tag()
	subtitle.text = set_center_tags(blue_text+green_text+red_text)
	

func get_bbcode_color_tag(color = null) -> String:
	if color: return "[color=#" + color.to_html() + "]" 
	else: return "[/color]"


func set_center_tags(string_to_center: String) -> String: 
	return "[center]" + string_to_center + "[/center]"
	

"""
	Todo: 
		- Put subtitle in own component. 
		- Add choose your own adventure choices
		- Find way to store dialogue 
			* Dicionary? JSON? Within each level or standalone? 
			* Consider who is saying dialogue. 
		- Level select
"""
			
			
		
		
		

