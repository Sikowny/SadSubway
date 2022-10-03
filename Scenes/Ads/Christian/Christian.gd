extends Ad

func _on_button_pressed():
	self.emit_signal("ad_finished", true, null)

func _on_Yes_pressed():
	self.emit_signal("ad_finished", false, "You dated a Christian.")
