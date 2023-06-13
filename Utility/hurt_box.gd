extends Area2D

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage)

func _on_area_entered(area):
	if area.is_in_group("attack"): 
		if not area.get("damage") == null:
			collision.call_deferred("set", "disabled", true)
			disableTimer.start() 
			var damage = area.damage
			emit_signal("hurt", damage)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)

func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)

