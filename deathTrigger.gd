extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_deathTrigger_body_entered(body):
	if body is Player:
		body.playerDeath()
		
