extends Node2D

const DIALOGUE_BUBBLE = preload("res://scenes/dialogue/dialogue_bubble.tscn")

## Temporary variables: 
var temp_personality
const GHESS = preload("res://utils/resources/Ghess.tres")

# Places to spawn the dialogue. 
@onready var dialogue_marker_1: Marker2D = $Markers/DialogueMarker1
@onready var dialogue_marker_2: Marker2D = $Markers/DialogueMarker2
@onready var dialogue_marker_3: Marker2D = $Markers/DialogueMarker3
@onready var dialogue_marker_4: Marker2D = $Markers/DialogueMarker4

# Scenario = a question and options 
# Question = asked to the player by the ghost to romance. 
# Option = possible response to a question. There is only one right answer to a question. 
	# Answer quickly and correctly to romance her and avoid death. 

var current_character  # The ghost to romance. 
var current_scenario_index: int = 1  # Keeps track of the current scenario
var current_question
@onready var question: RichTextLabel = $Question  # Display s the question on the screen. 

# Holds each of the dialogue options instaces. 
@onready var options: Node2D = $Options

var active_option  # Reference to the active option. 
var active_string  # The string to be typed from the active option. 

var index: int = 0  
	# Index of the current char in the active option.
	# Keeps track of where we are in the sentence of the active option. 

func _ready() -> void:
	# Gets the dialogue json. 
	var file = FileAccess.open("res://assets/json/text.json", FileAccess.READ) 
	var json = JSON.new() 
	var data = json.parse_string(file.get_as_text())
	
	# Get character
	current_character = data["character_1"]
	
	temp_personality = current_character.get("personality")
	
	get_scenario()
	
	print(GHESS.sense_of_humor)


# Gets the scenario based on the current scenario index. 
func get_scenario(): 
	# Clear all current options.
	for option in options.get_children(): 
		option.queue_free()
	
	# Get question.
	question.text = "[center]" + current_character.get(str(current_scenario_index)).get("question") + "[/center]"

	# Get all dialogue options.
	var i = 1
	var options_dictionary = current_character.get(str(current_scenario_index))

	for option in options_dictionary: 
		# This is the question, not an option.
		if str(option) == "question": continue
		
		var option_string = current_character[str(current_scenario_index)][str(option)]
		var dialogue_bubble = DIALOGUE_BUBBLE.instantiate()
		match i: 
			1: 
				dialogue_bubble.init(option_string, dialogue_marker_1.position)
			2: 
				dialogue_bubble.init(option_string, dialogue_marker_2.position) 
			3: 
				dialogue_bubble.init(option_string, dialogue_marker_3.position) 
			4: 
				dialogue_bubble.init(option_string, dialogue_marker_4.position) 
			_: 
				dialogue_bubble.init(option_string, dialogue_marker_1.position)
		
		i+=1
		options.add_child(dialogue_bubble)


func _unhandled_input(event: InputEvent) -> void:
	# Inputted a key 
	if event is InputEventKey and event.is_pressed(): 
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		
		# See if the key starts with one of the options. 
		if not active_option: 
			for option in options.get_children(): 
				# Key matches one of the options. 
				# Set that option as the active option. 
				if key_typed == option.raw_text[0]: 
					active_option = option	
					active_string = active_option.raw_text 
					active_option.text = Globals.format_string(index, active_string)
					index = min(index+1, active_option.raw_text.length())
		
		# Only do this if there is an active option. 
		else: 
			# Typed the correct character.
			if key_typed == active_string[min(index, active_string.length()-1)]:
				# Advance to the next character
				active_option.text = Globals.format_string(index, active_string)
				index = min(index+1, active_string.length())
				
				# Reached end of active_string. 
				if index == active_string.length(): 
					current_scenario_index += 1
					index = 0
					get_scenario()
				


				
		
			
		
