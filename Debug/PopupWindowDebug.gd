extends Node
	
export(PackedScene) var debug_scene;

func _ready():
	$PopupWindow.next_ad = debug_scene
	$PopupWindow.open_new_ad()
