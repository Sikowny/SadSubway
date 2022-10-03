extends Area2D

# Based on the coin code from 2D Platformer Toolkit!

#onready var audio = $AudioStreamPlayer

var collected = false

func _ready():
	visible = true
	#Global.init_coin()

func collect():
	visible = false
	collected = true
	$sfx.playing = true
	
	#if Global.max_coins != 1:
		#audio.pitch_scale = (float(Global.current_coins) / (Global.max_coins - 1)) + 1
	#print(audio.pitch_scale)
	#Global.collect_coin()
	#audio.play(0)
	

func _on_Coin_body_entered(body):
	if body is Player:
		if(!collected): collect()

#func _on_AudioStreamPlayer_finished():
	#queue_free()
