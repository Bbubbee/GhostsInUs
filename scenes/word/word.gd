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


func is_typed_correctly(key, index): 
	if key == raw_text[index]: return true
	else: return false
	
