extends Ad

export(int) var needed_no_hovers = 6

func _on_Yes_pressed():
	emit_signal("ad_finished", false, "You're now rich, but at what cost?")

func _on_No_pressed():
	emit_signal("ad_finished", true, null)

func _on_No_mouse_entered():
	if needed_no_hovers > 0:
		needed_no_hovers -= 1;
		$No.rect_position.x = randi() % 500
		$No.rect_position.y = randi() % 500
		$Yes.rect_position.x = randi() % 500
		$Yes.rect_position.x = randi() % 500
