extends Node2D
class_name Level

"""
	Dependencies: 
		Types.EnterParams
			* An autoload "Types" node with class "EnterParams" 
"""

signal change_level(level_path: String, enter_params: Types.EnterParams)


func init(enter_params: Types.EnterParams = null): 
	if enter_params: 
		print("Hey! I have enter params")
