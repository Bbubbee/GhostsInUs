extends Node


## Sets the subtitle based on a given string. 
## Formats the subtitle with the correct colors. 
## Colors for done, current, and todo chararacters.
func set_subtitle(
	index, 
	text, 
	before_color: Color = Color.YELLOW, 
	current_color: Color = Color.YELLOW, 
	after_color: Color = Color.WHITE
):
	# Correct chars. 
	var done_chars = get_bbcode_color_tag(before_color) + text.substr(0, index) + get_bbcode_color_tag()
	# Current char. 
	var current_chars = get_bbcode_color_tag(current_color) + text.substr(index, 1) + get_bbcode_color_tag()
	# Chars left to type.  
	var todo_chars = get_bbcode_color_tag(after_color) + "[u]" + text.substr(index+1, 1) + "[/u]" + text.substr(index+2, text.length()-1) + get_bbcode_color_tag()
	return set_center_tags(done_chars+current_chars+todo_chars)		
		
		
func get_bbcode_color_tag(color = null) -> String:
	if color: return "[color=#" + color.to_html() + "]" 
	else: return "[/color]"


func set_center_tags(string_to_center: String) -> String: 
	return "[center]" + string_to_center + "[/center]"
