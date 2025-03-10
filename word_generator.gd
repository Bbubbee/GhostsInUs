extends Node2D

var words = {
	"pleasant": Globals.traits.sweet,
	"pleasantly": Globals.traits.sweet,
	
	#"pretty": Globals.traits.sweet,
	#"darling": Globals.traits.sweet,
	#"lovely": Globals.traits.sweet,
	#"charming": Globals.traits.sweet,
	#"adorable": Globals.traits.sweet,
	#"affectionate": Globals.traits.sweet,
	#"honeyed": Globals.traits.sweet,
	#"melodious": Globals.traits.sweet,
	#"gentle": Globals.traits.sweet,
	#
	#"bittersweet": Globals.traits.sour,
	#"melancholy": Globals.traits.sour,
	#"solitude": Globals.traits.sour,
	#"yearning": Globals.traits.sour,
	#"whispers": Globals.traits.sour,
	#"shadows": Globals.traits.sour,
	#"regret": Globals.traits.sour,
	#"fractures": Globals.traits.sour,
	#"storms": Globals.traits.sour,
	#"elegy": Globals.traits.sour,
	#
	#"depth": Globals.traits.savory,
	#"warmth": Globals.traits.savory,
	#"wisdom": Globals.traits.savory,
	#"mystique": Globals.traits.savory,
	#"reverie": Globals.traits.savory,
	#"grit": Globals.traits.savory,
	#"ember": Globals.traits.savory,
	#"valor": Globals.traits.savory,
	#"legacy": Globals.traits.savory,
	#"rhythm": Globals.traits.savory
}

	
func get_word(): 
	var word = words.keys().pick_random()
	var feeling = words[word] 
	return [word, feeling]
	
