extends KinematicBody2D
class_name Player
# Stats
const gSS = 64; #gridSpaceSize
export var accelX = gSS*1;
export var gravity = gSS*0.7
export var friction_curr = gSS*0.5
export var jumpStr = -gSS*15;
export var jump_count = 1
export var MAX_VEL_X = gSS*7;
export var MAX_VEL_Y = gSS*20;
var snap = Vector2(0,gSS*0.3);

# States
var facing = 1
#var grounded = 1 use is_on_floor()
var jumps_left = jump_count
var velocity = Vector2.ZERO
var Move = Vector2.ZERO

enum STATE {
	IDLE,
	RUN,
	AIR_NEUTRAL
}

var playerState = STATE.IDLE



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	do_playerInput();
	# reset snap
	snap = Vector2(0,gSS*0.3);
	
	# ------ do movement -------
	if(Move.x != 0):
		if is_on_floor(): playerState = STATE.RUN
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
		if(Move.x == 0): playerState = STATE.IDLE
		jumps_left = jump_count;
	else: #AIR BOURNE
		playerState = STATE.AIR_NEUTRAL
		velocity.y += gravity;
		
		
	
	#Jump code
	var isJumping = Input.is_key_pressed(KEY_W) || Input.is_key_pressed(KEY_SPACE)
	#var isJumping = Input
	
	if(isJumping):
		if(jumps_left > 0):
			print("jump")
			velocity.y = jumpStr;
			jumps_left -= 1
			snap *= 0;
	
	velocity.x = clamp(velocity.x , -MAX_VEL_X, MAX_VEL_X)
	velocity.y = clamp(velocity.y, -MAX_VEL_Y, MAX_VEL_Y)
	
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	#velocity = move_and_slide(velocity, Vector2.UP)
	
	
	
	do_playerAnimation()

func do_playerInput():
	var MoveX = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var MoveX1 = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A))
	var MoveY = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	var MoveY1 = int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))
	Move = Vector2(MoveX1,MoveY1).normalized()
	
func do_playerAnimation():
	if(facing == -1):
		$AnimatedSprite.flip_h = true
	elif(facing == 1):
		$AnimatedSprite.flip_h = false
		
	match(playerState):
		STATE.IDLE:
			$AnimatedSprite.animation = "Idle"
		STATE.RUN:
			$AnimatedSprite.animation = "Run"
			$AnimatedSprite.playing = true
		STATE.AIR_NEUTRAL:
			$AnimatedSprite.animation = "Air Neutral"
			if(velocity.y < 0): #going up
				if(abs(velocity.x) > gSS*2): $AnimatedSprite.frame = 3
				else:  $AnimatedSprite.frame = 2
			else: #going down
				if(abs(velocity.x) > gSS*2): $AnimatedSprite.frame = 1
				else:  $AnimatedSprite.frame = 0
				

func is_player():
	return true


