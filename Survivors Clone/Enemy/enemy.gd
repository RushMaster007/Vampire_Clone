extends CharacterBody2D

@export var movement_speed = 20.0
@export var hp = 10
@export var experience = 1

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot") #Group "loot"

var exp_gem = preload("res://Objects/experience_gem.tscn") #Element Experience_Gen

#func _ready():
	#_on_hurtbox_hurt(99)
	
func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*movement_speed
	move_and_slide()

func death():
	#------ Drops Experience-Gem 
	var new_gem = exp_gem.instantiate() #generates new gem
	new_gem.global_position = global_position #new gem position = position of (dead) enemy
	new_gem.experience = experience #value of experience is set
	loot_base.call_deferred("add_child", new_gem) #new gem is added to group "loot"
	
	queue_free() #enemy gets deleted

func _on_hurtbox_hurt(damage):
	hp -= damage
	if hp <= 0:
		death()
