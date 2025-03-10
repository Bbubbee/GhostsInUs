extends RichTextLabel
class_name Word

var feeling: Globals.traits
var raw_text: String

func init(text: String, feeling: Globals.traits): 
	self.text = "[center]" + text + "[/center]"
	raw_text = text
	self.feeling = feeling


func show_text(index: int): 
	self.text = Globals.format_string(index, raw_text)


func clear_text(): 
	self.text = "[center]" + raw_text + "[/center]"
	

func is_correct(string_to_check: String): 
	if string_to_check == raw_text: return true
	return false


func is_typed_correctly(key, index): 
	# TODO: Temp way of checking if word is completed. 
	# If the word is completed
	if index >= raw_text.length(): return true
	
	if key == raw_text[index]: return true
	else: return false
	
