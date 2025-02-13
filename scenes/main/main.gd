extends Node2D

@onready var subtitle: RichTextLabel = $Subtitle

@export var done_color: Color = Color("#4682b4")
@export var current_color: Color = Color("#639765")
@export var todo_color: Color = Color("#a65455")

var points = 1 

var index: int = 0
var text: String = "tit"


func _ready() -> void:
	set_subtitle()

 
func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventKey and event.is_pressed(): 
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
			
		# Typed the correct character. 
		if key_typed == text[min(index, text.length()-1)]:
			# Advance to the next character. 
			index = min(index+1, text.length())
			set_subtitle()
		
		# Finished the word
		if index == text.length(): 
			index = 0 
			text = "pussy ass hoe"
			set_subtitle()
			
		
	

"""
	Sets the subtitle based on a given string. 
	Formats the subtitle with the correct colors. 
	Colors for done, current, and todo chararacters.
"""
func set_subtitle():
	# Correct chars. 
	var done_chars = get_bbcode_color_tag(done_color) + text.substr(0, index) + get_bbcode_color_tag()
	# Current char. 
	var current_chars = get_bbcode_color_tag(current_color) + text.substr(index, 1) + get_bbcode_color_tag()
	# Chars left to type.  
	var todo_chars = get_bbcode_color_tag(todo_color) + text.substr(index+1, text.length()-1) + get_bbcode_color_tag()
	subtitle.text = set_center_tags(done_chars+current_chars+todo_chars)		
		
func get_bbcode_color_tag(color = null) -> String:
	if color: return "[color=#" + color.to_html() + "]" 
	else: return "[/color]"

func set_center_tags(string_to_center: String) -> String: 
	return "[center]" + string_to_center + "[/center]"
