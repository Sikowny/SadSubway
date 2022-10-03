extends Node

# DO NOT CHANGE
enum {TITLE_SCREEN, GAME_OVER, GAME}

signal state_changed(old_state, new_state);

export(PackedScene) var first_level;
var level;

var state = -1 setget set_state

func set_state(new_state):
	if state != new_state:
		emit_signal("state_changed", state, new_state)
		state = new_state

var ad_is_open = false setget set_ad_is_open

func set_ad_is_open(new_bool):
	if ad_is_open != new_bool:
		ad_is_open = new_bool
		if ad_is_open:
			$Music.playing = false
		else:
			$Music.playing = true

func _ready():
	set_state(TITLE_SCREEN)

func _on_PopupWindow_ad_finished(is_success):
	set_ad_is_open(false)
	if is_success:
		$PopupTimer.start()
	else:
		set_state(GAME_OVER)

func _on_Main_state_changed(old_state, new_state):
	if old_state == GAME_OVER:
		$UI/GameOver.visible = false
	elif old_state == TITLE_SCREEN:
		$UI/TitleScreen.visible = false
	elif old_state == GAME:
		pass
		
	if new_state == GAME_OVER:
		$UI/GameOver.visible = true
	elif new_state == TITLE_SCREEN:
		$UI/TitleScreen.visible = true
	elif new_state == GAME:
		set_ad_is_open(false)
		$PopupTimer.start()
		level = first_level.instance()
		get_tree().get_root().add_child(level)

func _on_StartButton_pressed():
	set_state(GAME)
	
func _on_PopupTimer_timeout():
	print("a")
	set_ad_is_open(true)

func _on_Title_pressed():
	set_state(TITLE_SCREEN)

func _on_Continue_pressed():
	Global.restart_level()
