extends Node2D

const WORD = preload("res://scenes/word/word.tscn")


@onready var word_generator = $WordGenerator

# Contains all the word nodes on screen. 
@onready var words = $Words
var active_words: Array[Word] = []
var index: int:
	set(val):
		# TEMP:
		if not active_words: 
			index = 0
			return
		
		var longest_word: int = 0
		for word in active_words: 
			# Get the longest word.
			if word.raw_text.length() >= longest_word: 
				longest_word = word.raw_text.length()
		
		index = min(val, longest_word-1)
	
# The word the user has currently typed.
var typed_word: String

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
	if event is InputEventKey and event.is_pressed() and not event.is_action_pressed("enter_word"): 
		
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		
		## There are no active words. 
		#  Check if key matches any words on the screen. 
		if not active_words: 
			for word in words.get_children(): 
				if key_typed == word.raw_text[0]: 
					active_words.append(word)
					word.show_text(index) 
			
			# TEMP: Only go to next character if correct. 
			if active_words: index += 1
			
		## There are active words. 
		# See if the key matches the the current character in
		# any active words. 
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
			
			if active_words: 
				index += 1
			else: 
				index = 0		
		
		# TODO: Temp way of clearing typed word if there are no active words. 
		if active_words:
			typed_word += key_typed
		else:
			typed_word = ""
			
			
	## Enter is pressed. 
	## Check if any words have been completed. If so, increase score. 
	if event.is_action_pressed("enter_word"):
		# TODO: Temp way of checking index+1 (the next character) 
		var new_index = index+1 
		
		# TODO: Temp way of clearing words (because a correct one was entered).
		var clear_words: bool = false
		
		# Check if any of the active words are complete (correct)
		for word in active_words: 
			if word.is_correct(typed_word): 
				print("Correct!: " + word.raw_text)
				Events.increase_score.emit()
				clear_words = true
		
		# Clear active words.
		if clear_words: 
			index = 0 
			for word in active_words:
				word.clear_text()
			active_words = []
			typed_word = ""
			
				
					
				

					
	
	
