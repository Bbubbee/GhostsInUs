extends Node2D

const DIALOGUE_BUBBLE = preload("res://scenes/dialogue/dialogue_bubble.tscn")

var current_character
var current_question: int = 1

# Places to spawn the dialogue. 
@onready var dialogue_marker_1: Marker2D = $Markers/DialogueMarker1
@onready var dialogue_marker_2: Marker2D = $Markers/DialogueMarker2
@onready var dialogue_marker_3: Marker2D = $Markers/DialogueMarker3
@onready var dialogue_marker_4: Marker2D = $Markers/DialogueMarker4

# Holds each of the dialogue options. 
@onready var options: Node2D = $Options

var active_option  
var active_string 

# Index of the current char in the active_option
var index: int = 0

func _ready() -> void:
	# Gets the dialogue json. 
	var file = FileAccess.open("res://assets/json/text.json", FileAccess.READ) 
	var json = JSON.new() 
	var data = json.parse_string(file.get_as_text())
	current_character = data["character_1"]
	
	var i = 1
	# Get all dialogue options
	for option in current_character[str(current_question)]: 
		# This is the question, not an option.
		if str(option) == "question": continue
		
		var dialogue_string = current_character[str(current_question)][str(option)]
		var dialogue_bubble = DIALOGUE_BUBBLE.instantiate()
		match i: 
			1: 
				dialogue_bubble.init(dialogue_string, dialogue_marker_1.position)
			2: 
				dialogue_bubble.init(dialogue_string, dialogue_marker_2.position) 
			3: 
				dialogue_bubble.init(dialogue_string, dialogue_marker_3.position) 
			4: 
				dialogue_bubble.init(dialogue_string, dialogue_marker_4.position) 
			_: 
				dialogue_bubble.init(dialogue_string, dialogue_marker_1.position)
				
		i+=1
		options.add_child(dialogue_bubble)


func _unhandled_input(event: InputEvent) -> void:
	# Inputted a key 
	if event is InputEventKey and event.is_pressed(): 
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		
		# Get the first letter of each option. 
		if not active_option: 
			for option in options.get_children(): 
				if key_typed == option.raw_text[0]: 
					active_option = option	
					active_string = active_option.raw_text 
					active_option.text = Globals.format_string(index, active_string)
					index = min(index+1, active_option.raw_text.length())
					print('lol')
		else: 
			# Typed the correct character
			if key_typed == active_string[min(index, active_string.length()-1)]:
				## Advance to the next character
				active_option.text = Globals.format_string(index, active_string)
				index = min(index+1, active_string.length())
				


				
		
			
		
