extends Node2D

const WORD = preload("res://scenes/word/word.tscn")


@onready var word_generator = $WordGenerator

# Contains all the word nodes on screen. 
@onready var words = $Words
var active_words = []
var index: int:
	set(val): 
		index = val

func _ready():
	
	# Spawn a bunch of temporary words 
	var window_size = get_viewport_rect().size
	for i in range(4): 
		var word = WORD.instantiate() 
		var random_word = word_generator.get_word()
		word.init(random_word[0], random_word[1])
		match i: 
			0: 
				word.position = Vector2(window_size.x/2, 0+100)  
			1: 
				word.position = Vector2(window_size.x/2, window_size.y-100)  
			2: 
				word.position = Vector2(150, window_size.y/2)  
			3: 
				word.position = Vector2(window_size.x-150, window_size.y/2) 
		
		words.add_child(word) 


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed(): 
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		
		# There are no active words. 
		if not active_words: 
			for word in words.get_children(): 
				if key_typed == word.raw_text[0]: 
					active_words.append(word)
					word.show_text(index) 
			
			index += 1
			
 	
		## There are active words. 
		else: 
			for word in active_words: 
				print("checking this word: ", word.raw_text)
				if word.is_typed_correctly(key_typed, index):
					word.show_text(index)  
				else: 
					# Remove this word from the active words. 
					active_words.erase(word) 
					print('removing', word.raw_text)
					
					
			index += 1
			
		
#var active_option  # Reference to the active option. 

		#if not active_option: 
			#for word in words.get_children(): 
				## Key matches one of the options. 
				## Set that option as the active option. 
				#if key_typed == option.raw_text[0]: 
					#active_option = word	
					#active_string = active_option.raw_text 
					#active_option.text = Globals.format_string(index, active_string)
					#index = min(index+1, active_option.raw_text.length())
		#
		## Only do this if there is an active option. 
		#else: 
			## Typed the correct character.
			#if key_typed == active_string[min(index, active_string.length()-1)]:
				## Advance to the next character
				#active_option.text = Globals.format_string(index, active_string)
				#index = min(index+1, active_string.length())
				#
				## Reached end of active_string. 
				#if index == active_string.length(): 
					#current_scenario_index += 1
					#index = 0
					#get_scenario()
					
