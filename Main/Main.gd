extends Node

# DO NOT CHANGE
enum {TITLE_SCREEN, GAME_OVER, GAME}

signal state_changed(old_state, new_state);
const music = preload("res://Audio/Music/Main Theme 1.2.mp3")
const music2 = preload("res://Audio/Music/Main Theme2.3.mp3")

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
			$Music.stream_paused = true
		else:
			$Music.stream_paused = false

func _ready():
	set_state(TITLE_SCREEN)

func _on_PopupWindow_ad_finished(is_success, message):
	set_ad_is_open(false)
	if is_success:
		$PopupTimer.start()
		$adClose.play()
	else:
		set_state(GAME_OVER)
		if message == null:
			$UI/GameOver/CenterContainer/Tagline.text = ""
		else:
			$UI/GameOver/CenterContainer/Tagline.text = message

func _on_Main_state_changed(old_state, new_state):
	if old_state == GAME_OVER:
		$UI/GameOver.visible = false
		$UI/GameOver/CenterContainer/Tagline.text = ""
	elif old_state == TITLE_SCREEN:
		$UI/TitleScreen.visible = false
	elif old_state == GAME:
		pass
		
	if new_state == GAME_OVER:
		$UI/GameOver.visible = true
	elif new_state == TITLE_SCREEN:
		$UI/TitleScreen.visible = true
		if old_state == GAME_OVER:
			get_node("/root").get_child(2).queue_free()
	elif new_state == GAME:
		set_ad_is_open(false)
		$PopupTimer.start()
		if old_state == TITLE_SCREEN:
			level = first_level.instance()
			get_tree().get_root().add_child(level)
		elif old_state == GAME_OVER:
			Global.restart_level()

func _on_StartButton_pressed():
	set_state(GAME)
	
func _on_PopupTimer_timeout():
	print("a")
	set_ad_is_open(true)
	$adOpen.play()

func _on_Title_pressed():
	set_state(TITLE_SCREEN)

func _on_Continue_pressed():
	set_state(GAME)
	
func set_music(value):
	match value:
		0: pass
		1: 
			$Music.stream = music; 
			$Music.playing = true
		2: 
			$Music.stream = music2; 
			$Music.playing = true
