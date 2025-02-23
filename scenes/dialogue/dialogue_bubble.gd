extends RichTextLabel


func init(message: String, pos: Vector2) -> void:
	global_position = pos
	text = message


func type(char: String):
	pass
