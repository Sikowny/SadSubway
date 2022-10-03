extends Popup

signal ad_finished(is_success, optional_message);

# A value from 0 to 2
export var difficulty = 0;

export(Array, Array, PackedScene) var ads;

var last_choice = 1;

var next_ad;

# randomly selects ad in given difficulty
func preload_next_ad():
	randomize()
	var a = ads[difficulty];
	var index = posmod(randi(), a.size())
	while index == last_choice:
		if a.size() == 1:
			break
		index = posmod(randi(), a.size())
		
	next_ad = a[index]
	last_choice = index

func open_new_ad():
	popup_centered()
	var ad = next_ad.instance();
	ad.connect("ad_finished", self, "close_current_ad")
	$Container/Viewport.add_child(ad)
	
func close_current_ad(is_success, optional_message):
	hide()
	preload_next_ad()
	for child in $Container/Viewport.get_children():
		child.queue_free()
	emit_signal("ad_finished", is_success, optional_message)

func _ready():
	preload_next_ad()
