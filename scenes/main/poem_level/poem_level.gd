extends Node2D

const WORD = preload("res://scenes/word/word.tscn")

@onready var word_spawn_timer: Timer = $WordSpawnTimer


@onready var word_generator: WordGenerator = $WordGenerator

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

@onready var window_size = get_viewport_rect().size


## Handles all the typing. (main gameplay loop) 
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
			
			# Only go to next character if correct. 
			if active_words: index += 1
			
		## There are active words. 
		# See if the key matches the current character in
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
			
			if active_words: index += 1
			else: index = 0		
		
		# TODO: Temp way of clearing typed word if there are no active words. 
		if active_words: typed_word += key_typed
		else: typed_word = ""
			
			
	## Enter is pressed. 
	## Check if any words have been completed. If so, increase score. 
	if event.is_action_pressed("enter_word"):
		# TEMP: Temp way of checking index+1 (the next character) 
		var new_index = index+1 
		
		# TEMP: Correct word. 
		var correct_word: Word 
		
		# Check if any of the active words are complete (correct)
		var clear_words: bool = false
		for word in active_words: 
			if word.is_correct(typed_word): 
				correct_word = word
				print("Correct!: " + word.raw_text)
				Events.increase_score.emit()
				clear_words = true
		
		# TEMP: Temp way of clearing words (because a correct one was entered).
		if clear_words: 
			index = 0 
			for word in active_words:
				word.clear_text()
			active_words = []
			typed_word = ""
			
			correct_word.word_is_correct()
			
			

func _on_word_spawn_timer_timeout() -> void:
	spawn_mover()
	

func spawn_mover(): 
	# TEMP: Spawn a mover word. 
	var word = WORD.instantiate()
	var random_word = word_generator.get_word()
	word.init(random_word[0], random_word[1], Word.Type.MOVER)
	word.delete_me.connect(_on_delete_word)
	words.add_child(word)
	
	# Randomly choose which direction to spawn from. 
	# Up, down, left, right. 
	var r = randi_range(0, 3)
	var start_pos: Vector2
	var dir: Vector2
	#r = 2
	match r: 
		0: 
			word.direction = Vector2.LEFT
			start_pos = Vector2(window_size.x+50, randi_range(0, window_size.y-50))
		1: 
			word.direction = Vector2.RIGHT 
			start_pos = Vector2(0-79, randi_range(0, window_size.y-50))
		2: 
			word.direction = Vector2.UP 
			start_pos = Vector2(randi_range(0, window_size.x), window_size.y)
		3: 
			word.direction = Vector2.DOWN 
			start_pos = Vector2(randi_range(0, window_size.x), -50)
		_: 
			pass
	
	word.position = Vector2(start_pos)


func _on_delete_word(deleted_word: Word): 
	active_words.erase(deleted_word) 
	word_generator.remove_word(deleted_word.raw_text)
	



	
	
	
	
