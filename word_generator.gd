extends Node2D

@export var json_file: JSON
const WORD = preload("res://scenes/word/word.tscn")



var words = {
	"pleasant": Globals.traits.sweet,
	"cute": Globals.traits.sweet,
	"darling": Globals.traits.sweet,
	"lovely": Globals.traits.sweet,
	"charming": Globals.traits.sweet,
	"adorable": Globals.traits.sweet,
	"affectionate": Globals.traits.sweet,
	"honeyed": Globals.traits.sweet,
	"melodious": Globals.traits.sweet,
	"gentle": Globals.traits.sweet,
	
	"bittersweet": Globals.traits.sour,
	"melancholy": Globals.traits.sour,
	"solitude": Globals.traits.sour,
	"yearning": Globals.traits.sour,
	"whispers": Globals.traits.sour,
	"shadows": Globals.traits.sour,
	"regret": Globals.traits.sour,
	"fractures": Globals.traits.sour,
	"storms": Globals.traits.sour,
	"elegy": Globals.traits.sour,
	
	"depth": Globals.traits.savory,
	"warmth": Globals.traits.savory,
	"wisdom": Globals.traits.savory,
	"mystique": Globals.traits.savory,
	"reverie": Globals.traits.savory,
	"grit": Globals.traits.savory,
	"ember": Globals.traits.savory,
	"valor": Globals.traits.savory,
	"legacy": Globals.traits.savory,
	"rhythm": Globals.traits.savory
}
	


func _ready() -> void:	
	# Spawn one word. 
	var word = WORD.instantiate() 
	var random_word = pick_random()
	word.init(pick_random(), words.get(random_word))
	#word.position = self.position
	word.position = Vector2(100, 100)
	self.add_child(word) 
	
	
		
	
	
func pick_random(): 
	var random_key = words.keys().pick_random()
	return random_key
