extends CharacterBody2D

class_name Enemy

# Enemy Info
@export var movement_speed = 20.0
@export var Sprite:Texture
@export var Enemy_Type = 0
@export var damage = 5.0

# Spawn Info
@export var time_start:int
@export var time_end:int
@export var enemy_num:int
@export var enemy_spawn_delay:int

var spawn_delay_counter = 0

@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	var distance = global_position.distance_to(player.global_position)
	if distance <= 0.1 or distance >= -0.1:
		move_and_slide()
