extends Area2D

export(PackedScene) var target

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _on_LevelChange_body_entered(body):
	if body is Player:
		owner.queue_free()
		var t = target.instance()
		var root = get_tree().get_root()
		root.add_child(t)
