extends Area2D

export var target = "res://Debug/Brendan's Test.tscn"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func _on_LevelChange_body_entered(body):
	if body is Player:
		get_tree().change_scene(target)
