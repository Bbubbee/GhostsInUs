extends RichTextLabel
class_name Word

var feeling: Globals.traits
var raw_text: String
var direction: Vector2 = Vector2.ZERO

signal delete_me(word: Word)


var type: Type
enum Type {
	MOVER, 
	SPAWNER
}


func init(text: String, feeling: Globals.traits, type: Type, dir: Vector2 = Vector2.ZERO): 
	self.text = "[center]" + text + "[/center]"
	self.raw_text = text
	self.feeling = feeling
	self.type = type
	
	if dir: 
		self.direction = dir
	
	
func _physics_process(delta: float) -> void:
	if type == 0: 
		move_word()
		is_outside_of_boundaries()
	
	
func is_outside_of_boundaries() -> bool: 
	if position.x <= -200: 
		delete_me.emit(self) 
		queue_free()
	
	return true 


func move_word(): 
	if direction == Vector2.LEFT: 
		self.position.x -= 4
	elif direction == Vector2.RIGHT:  
		self.position.x += 4 
	elif direction == Vector2.UP: 
		self.position.y -= 4
	elif direction == Vector2.DOWN: 
		self.position.y += 4
	#else: 
		#self.position.x -= 5


func show_text(index: int): 
	self.text = Globals.format_string(index, raw_text)


func clear_text(): 
	self.text = "[center]" + raw_text + "[/center]"
	

func is_correct(string_to_check: String): 
	if string_to_check == raw_text: return true
	return false


func is_typed_correctly(key, index): 
	# TEMP: Checking if word is completed. 
	# If the word is completed then it is typed correctly. Disregard keys after. 
	if index >= raw_text.length(): return true
	
	if key == raw_text[index]: return true
	else: return false
	
