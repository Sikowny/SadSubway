extends Node2D
	
func _process(delta):
	if Input.is_action_just_pressed("debug"):
		$Control/Popup.popup_centered()
