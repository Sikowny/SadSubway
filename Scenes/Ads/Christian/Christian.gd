extends Ad

func _on_button_pressed():
	self.emit_signal("ad_finished", true)
