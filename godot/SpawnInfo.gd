extends Resource

class_name SpawnInfo

# Enemy Info
@export var movement_speed = 20.0
@export var Sprite:Resource
@export var Enemy_Type = 0
@export var damage = 5.0

# Spawn Info
@export var time_start:int
@export var time_end:int
@export var enemy_num:int
@export var enemy_spawn_delay:int

var spawn_delay_counter = 0
