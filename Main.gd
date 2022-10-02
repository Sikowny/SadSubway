extends Node

enum {TITLE_SCREEN, GAME_OVER, GAME}

signal state_changed(old_state, new_state);

export(PackedScene) var first_level;
var level;

var state = -1 setget set_state

func set_state(new_state):
	if state != new_state:
		emit_signal("state_changed", state, new_state)
		state = new_state

func _ready():
	set_state(TITLE_SCREEN)

func _on_PopupWindow_ad_finished(is_success):
	if is_success:
		$PopupTimer.start()
	else:
		state = GAME_OVER

func _on_Main_state_changed(old_state, new_state):
	if old_state == GAME_OVER:
		$GameOver.visible = false
	elif old_state == TITLE_SCREEN:
		$TitleScreen.visible = false
	elif old_state == GAME:
		pass
		
	if new_state == GAME_OVER:
		$GameOver.visible = true
	elif new_state == TITLE_SCREEN:
		$TitleScreen.visible = true
	elif new_state == GAME:
		$PopupTimer.start()
		level = first_level.instance()
		add_child(level)

func _on_StartButton_pressed():
	set_state(GAME)
