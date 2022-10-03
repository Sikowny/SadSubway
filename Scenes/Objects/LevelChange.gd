extends Area2D

export(PackedScene) var target
export var musicChange = 0
export var difficultyChange = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true

func _on_LevelChange_body_entered(body):
	if body is Player:
		owner.queue_free()
		var t = target.instance()
		var root = get_tree().get_root()
		root.add_child(t)
		Global.set_difficulty(difficultyChange)
		Global.set_music(musicChange)
