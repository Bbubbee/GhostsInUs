extends Node2D

@onready var subtitle: RichTextLabel = $DialogueOption

@export var done_color: Color = Color("#4682b4")
@export var current_color: Color = Color("#639765")
@export var todo_color: Color = Color("#a65455")

var points = 1 

var index: int = 0
var text: String = "tit"

var current_line: int = 0
var lines: PackedStringArray

func _ready() -> void:
	var dialogue = "res://assets/text/dialogue.txt"
	var file = FileAccess.open(dialogue, FileAccess.READ)
	lines = file.get_as_text().split("\n")
	text = lines[0]
	subtitle.text = Globals.format_string(index, text, done_color, current_color, todo_color)

func _unhandled_input(event: InputEvent) -> void:
	# Inputted a key 
	if event is InputEventKey and event.is_pressed(): 
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
			
		# Typed the correct character
		if key_typed == text[min(index, text.length()-1)]:
			# Advance to the next character
			index = min(index+1, text.length())
			subtitle.text = Globals.format_string(index, text, done_color, current_color, todo_color)
		
		# Finished the word
		if index == text.length(): 
			index = 0 
			current_line += 1
			text = lines[min(current_line, lines.size()-1)]
			
			subtitle.text = Globals.format_string(index, text, done_color, current_color, todo_color)
		
