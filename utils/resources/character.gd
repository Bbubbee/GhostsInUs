extends Resource
class_name Character

@export var name: String

@export_category("Personality")
@export_enum("Sweet", "Sour", "Savoury") var flavor: String
@export_enum("Physical touch", "Words of affirmation", "Acts of service") var love_language: String
@export_enum("Sarcastic", "Silly", "Dark") var sense_of_humor: String
