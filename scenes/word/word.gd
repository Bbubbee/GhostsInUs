extends RichTextLabel
class_name Word

var feeling: Globals.traits
var raw_text: String
var direction: Vector2 = Vector2.ZERO
var speed: float = 100

signal delete_me(word: Word)

# Boundaries
var boundaries = {}
@onready var window_size = get_viewport_rect().size


var type: Type
enum Type {
	MOVER, 
	SPAWNER
}

func _ready():
	pass
	
	# Setup boundaries. 
	boundaries['left'] = 0 - 100
	boundaries['right'] = window_size.x + 100
	boundaries['top'] = 0 - 100
	boundaries['bot'] = window_size.y + 100
	


func init(t: String, f: Globals.traits, ty: Type, dir: Vector2 = Vector2.ZERO): 
	self.text = "[center]" + t + "[/center]"
	self.raw_text = t
	self.feeling = f
	self.type = ty
	
	if dir: self.direction = dir

	
func _physics_process(delta: float) -> void:
	if type == 0: 
		move_word(delta)
		is_outside_of_boundaries()
	
	
func is_outside_of_boundaries(): 
	if position.x <= boundaries['left']: delete_word()
	elif position.x >= boundaries['right']: delete_word()
	elif position.y <= boundaries['top']: delete_word()
	elif position.y >= boundaries['bot']: delete_word()


func move_word(delta: float): 
	if direction == Vector2.LEFT: 
		self.position.x -= speed * delta
	elif direction == Vector2.RIGHT:  
		self.position.x += speed * delta 
	elif direction == Vector2.UP: 
		self.position.y -= speed * delta
	elif direction == Vector2.DOWN: 
		self.position.y += speed * delta


func delete_word(): 
	#print('delete me')
	delete_me.emit(self) 
	queue_free()
	

func word_is_correct():
	delete_me.emit(self) 
	queue_free()


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
	
