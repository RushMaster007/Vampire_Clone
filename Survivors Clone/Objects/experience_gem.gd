extends Area2D

@export var experience = 1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $snd_collected

#Imgs for Gems
var spr_green = preload("res://Textures/Items/Gems/Gem_green.png")
var spr_blue = preload("res://Textures/Items/Gems/Gem_blue.png")
var spr_red = preload("res://Textures/Items/Gems/Gem_red.png")

var target = null
var speed = -1.0


func _ready():
	#------ Set color of gem
	if experience < 5: #if exp is less than 5 then the gem is green
		return
	elif experience < 25: #if exp is less than 25 then the gem is blue
		sprite.texture = spr_blue
	else: #else it is red
		sprite.texture = spr_red
		
func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, delta*speed)
		speed += 2
		
func collect():
	sound.play() 
	collision.call_deferred("set","disabled",true) 
	sprite.visible = false
	return experience
	
func _on_snd_collected_finished(): # sobald sound vorbei ist, entferne Exp
	queue_free()
