extends CharacterBody2D

# Time is measured in 1/60th of a second. -> 60 Frames = 1 Second

const MAX_DASH_DURATION = 60 # => 1s
const MAX_DASH_TIMEOUT = 150 # => 2.5s

var movement_speed = 80.0

var dash_duration_timer = MAX_DASH_DURATION
var dash_timeout_timer = MAX_DASH_TIMEOUT

#func _process(delta) ex 1/3000 

func _physics_process(_delta): # 1/60
	process_movement()
	
func process_movement():
	# TODO: Motion Mode: Floating
	# TODO: ProjectSettings -> Input-Map
	
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up") #  Up: negative, down: poistive
	var mov = Vector2(x_mov, y_mov);
	
	#Dash-Functionality
	if Input.get_action_strength("dash") == 1 && dash_timeout_timer >= MAX_DASH_TIMEOUT:
		dash_duration_timer = 0
		dash_timeout_timer = 0
		
	var dash_multiplier = 1
	
	# Count Timers
	if dash_duration_timer < MAX_DASH_DURATION:
		dash_duration_timer = dash_duration_timer + 1
		dash_multiplier = 5 # Set Multiplier
	
	if dash_timeout_timer < MAX_DASH_TIMEOUT:
		dash_timeout_timer = dash_timeout_timer + 1
		
	
		
	velocity = mov.normalized() * movement_speed * dash_multiplier
	
	move_and_slide() # Tells game to actually move the player body
