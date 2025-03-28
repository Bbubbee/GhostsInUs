extends Control

@onready var label = $Label

func _ready() -> void:
	print(label.size)
