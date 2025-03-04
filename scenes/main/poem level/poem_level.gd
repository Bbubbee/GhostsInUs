extends Node2D

const WORD = preload("res://scenes/word/word.tscn")


@onready var word_generator = $WordGenerator

# Contains all the word nodes on screen. 
@onready var words = $Words
var active_words: Array[Word] = []
var index: int:
	set(val):
		if not active_words: return
		
		var longest_word: int = 0
		for word in active_words: 
			# Get the longest word.
			if word.raw_text.length() >= longest_word: 
				longest_word = word.raw_text.length()
		
		index = min(val, longest_word-1)
	

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
		
			# TEMP: Only go to next character if correct. 
			if active_words: index += 1
			
 	
		# There are active words. 
		else: 
			# This is a list of words to remove from the active words. 
			# Remove these words if the typed character isn't correct. 
			var words_to_remove: Array[Word] = []
			for word in active_words: 
				# The typed character is correct for this word.
				if word.is_typed_correctly(key_typed, index):
					word.show_text(index)  
				else: 
					# Remove this word from the active words. 
					words_to_remove.append(word) 
			
			# Remove all incorrect words. 
			for word in words_to_remove: 
				word.clear_text()
				active_words.erase(word) 
			
					
					
			index += 1
	
