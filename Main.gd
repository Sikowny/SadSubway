extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var accelX = 1;
var MAX_VEL_X = 5;
var MAX_VEL_Y = 5;
var velX = 0;
var velY = 0;



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var MoveX = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var MoveY = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	var vector = Vector2(MoveX,MoveY).normalized()
	velX += vector.x*accelX;
	velY += vector.y;
	
	#friction
	if(MoveX == 0): velX = 0;
	if(MoveY == 0): velY = 0;
	
	#velX = clamp(velX, -MAX_VEL_X, MAX_VEL_X)
	
	if(abs(velX) > MAX_VEL_X): velX = MAX_VEL_X * sign(velX)
	if(abs(velY) > MAX_VEL_Y): velY = MAX_VEL_Y * sign(velY)
	
	var Move = Vector2(velX, velY)
	
	$Sprite.position += Move
