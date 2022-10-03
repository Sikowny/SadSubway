extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func ad_is_open():
	var main = get_node("/root/Main")
	if main == null:
		return false
	else:
		return main.ad_is_open

func game_over():
	var main = get_node("/root/Main")
	if main != null:
		main.state = 1

func restart_level():
	var level = get_parent().get_child(2)
	if(level != null):
		var restart_ = level.filename
		level.queue_free();
		level.get_parent().add_child(load(restart_).instance())

# Hey Brendan: use this for setting the difficulty
func set_difficulty(value):
	var main = get_node("/root/Main/UI/PopupWindow")
	if main != null:
		main.difficulty = value
