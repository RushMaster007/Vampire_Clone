extends CharacterBody2D

var movement_speed = 40.0

var hp = 80
var maxhp = 80

var experience = 0
var experience_level = 1
var collected_experience = 0

#GUI-elements
@onready var expBar = get_node("%ExperienceBar")
@onready var lblLevel = get_node("%lbl_level")
@onready var healthBar = get_node("%HealthBar")

func _ready():
	set_expbar(experience, calculate_experiencecap()) # Sets Experience-Bar
	_on_hurtbox_hurt(0) #initialize hp-bar

func _physics_process(delta):
	movement()
	
func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov,y_mov)
	velocity = mov.normalized()*movement_speed
	move_and_slide()

#---------functions for exp
func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self
	
func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_exp = area.collect()
		calculate_experience(gem_exp)

func calculate_experience(gem_exp):
	var exp_required = calculate_experiencecap()
	collected_experience += gem_exp
	if experience + collected_experience >= exp_required: 
		#------ level up
		collected_experience -= exp_required-experience # takes away the used exp
		experience_level += 1 
		lblLevel.text = str("Level:", experience_level) # prints new level
		experience = 0 # set exp to 0 on new level
		exp_required = calculate_experiencecap() # recalculates new cap
		calculate_experience(0) # calls the func again, so that all additional exp is counted
	else:
		experience += collected_experience # adds collected exp to exp
		collected_experience = 0
	set_expbar(experience, exp_required) # sets expBar to new value

func calculate_experiencecap(): #calculates how much exp is needed to get a level-up
	var exp_cap = experience_level
	if experience_level < 20:
		exp_cap = experience_level * 5
	elif experience_level < 40:
		exp_cap = 95 + (experience_level-19) * 8
	else:
		exp_cap = 255 + (experience_level-49) * 12
	return exp_cap

func set_expbar(set_value = 1, set_max_value = 100):
	expBar.value = set_value
	expBar.max_value = set_max_value

func _on_hurtbox_hurt(damage):
	hp -= damage

	#--- set the healthBar
	healthBar.max_value = maxhp
	healthBar.value = hp
	
	if hp <= 0:
		death()

func death():
	print("DEATH")
	get_tree().paused = true
	#----- back to menue
	#get_tree().paused = false
	#var _level = get_tree().change_scene_to_file(Menue)
