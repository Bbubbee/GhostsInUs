extends RichTextLabel

var raw_text

func init(message: String, pos: Vector2) -> void:
	global_position = pos
	raw_text = message
	text = "[center]" + message + "[/center]"


func type(char: String):
	pass
