extends Ad

export(float) var slot_1_speed = 1.0 * 60.0
export(float) var slot_2_speed = 1.0 * 60.0
export(float) var slot_3_speed = 1.0 * 60.0

enum {SEVEN, PLUM, ORANGE, SAD, BAR, CHERRY, NONE}

var slot_1_value = NONE;
var slot_2_value = NONE;
var slot_3_value = NONE;
var slot_1_section = null;
var slot_2_section = null;
var slot_3_section = null;

var slot_1_queued_stop = false;
var slot_2_queued_stop = false;
var slot_3_queued_stop = false;

func _ready():
	pass # Replace with function body.

func get_slot_value(slot):
	return posmod(slot.scroll_offset.y / (700.0/6), 6)

func get_slot_section(slot):
	return floor(slot.scroll_offset.y / (700.0/6))

func _process(delta):
	if slot_1_value == NONE:
		$Slot1.scroll_offset.y += slot_1_speed * delta;
	elif slot_1_queued_stop:
		$Slot1.scroll_offset.y += slot_1_speed * delta;
		if get_slot_section($Slot1) != slot_1_section:
			print(slot_1_value)
			slot_1_queued_stop = false;
		
	if slot_2_value == NONE:
		$Slot2.scroll_offset.y += slot_2_speed * delta;
	elif slot_2_queued_stop:
		$Slot2.scroll_offset.y += slot_2_speed * delta;
		if get_slot_section($Slot2) != slot_2_section:
			print(slot_2_value)
			slot_2_queued_stop = false;
	
	if slot_3_value == NONE:
		$Slot3.scroll_offset.y += slot_3_speed * delta;
	elif slot_3_queued_stop:
		$Slot3.scroll_offset.y += slot_3_speed * delta;
		if get_slot_section($Slot3) != slot_3_section:
			print(slot_3_value)
			slot_3_queued_stop = false;

func _on_Button1_pressed():
	$Button1.disabled = true
	slot_1_value = get_slot_value($Slot1)
	slot_1_queued_stop = true;
	slot_1_section = get_slot_section($Slot1)

func _on_Button2_pressed():
	$Button2.disabled = true
	slot_2_value = get_slot_value($Slot2)
	slot_2_queued_stop = true;
	slot_2_section = get_slot_section($Slot1)

func _on_Button3_pressed():
	$Button3.disabled = true
	slot_3_value = get_slot_value($Slot3)
	slot_3_queued_stop = true;
	slot_3_section = get_slot_section($Slot3)
