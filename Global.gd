extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func ad_is_open():
	var main = get_node("root/Main")
	if main == null:
		return true
	else:
		return main.ad_is_open
