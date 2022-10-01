extends KinematicBody2D

# Stats
var gSS = 64;
var accelX = gSS*1;
var gravity = gSS*0.3
var friction_curr = gSS*0.5
var jumpStr = -gSS*8;
var jump_count = 1
var MAX_VEL_X = gSS*5;
var MAX_VEL_Y = gSS*20;

# States
var facing = 1
#var grounded = 1 use is_on_floor()
var jumps_left = jump_count
var velocity = Vector2.ZERO
var Move = Vector2.ZERO




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var MoveX = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var MoveY = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	Move = Vector2(MoveX,MoveY).normalized()
	
	# ------ do movement -------
	if(Move.x != 0):
		velocity.x += Move.x*accelX;
		facing = Move.x;
		
	#friction
	if(Move.x == 0): 
		if(velocity.x != 0):
			if (abs(velocity.x) < friction_curr):
				velocity.x = 0;
			else:
				velocity.x -= friction_curr*sign(velocity.x)
			
	
	if is_on_floor():
		jumps_left = jump_count;
	else:
		velocity.y += gravity;
		
	
	#Jump code
	var isJumping = Input.is_action_just_pressed("ui_up")
	
	if(isJumping):
		if(jumps_left > 0):
			print("jump")
			velocity.y = jumpStr;
			jumps_left -= 1
	
	velocity.x = clamp(velocity.x , -MAX_VEL_X, MAX_VEL_X)
	velocity.y = clamp(velocity.y, -MAX_VEL_Y, MAX_VEL_Y)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if(facing == -1):
		$AnimatedSprite.flip_h = true
	elif(facing == 1):
		$AnimatedSprite.flip_h = false
