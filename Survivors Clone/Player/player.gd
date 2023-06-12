extends CharacterBody2D

var movement_speed = 60.0

#func _process(delta) ex 1/3000 

func _physics_process(delta): # 1/60
	process_movement()
	
func process_movement():
	
	# Calculate x- and y movement
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up") #  Up: negative, down: poistive
		
	# Create Movement-Vector
	var mov = Vector2(x_mov, y_mov);
	
	# Calculate and set player velocity
	velocity = mov.normalized() * movement_speed
	
	# Tells game to actually move the player body
	move_and_slide() 
