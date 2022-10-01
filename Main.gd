extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var accelX = 1;
var MAX_VEL_X = 3;
var MAX_VEL_Y = 3;
var vel2D = Vector2();
var Move = Vector2();



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var MoveX = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var MoveY = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	Move = Vector2(MoveX,MoveY).normalized()
	
	vel2D.x += Move.x*accelX;
	vel2D.y += Move.y;
	
	#friction
	if(Move.x == 0): vel2D.x = 0;
	if(Move.y == 0): vel2D.y = 0;
	
	vel2D.x = clamp(vel2D.x , -MAX_VEL_X, MAX_VEL_X)
	vel2D.y = clamp(vel2D.y, -MAX_VEL_Y, MAX_VEL_Y)
	
	
	$Sprite.position += vel2D
