# Projectile.gd
extends Area2D

var direction: Vector2 = Vector2.RIGHT
var speed: float = 800.0
var damage: int = 2

func _ready():
	print("spear dir: ", direction, " speed: ", speed)
	area_entered.connect(_on_area_entered)
	await get_tree().create_timer(8.0).timeout
	queue_free()

func _physics_process(delta):
	rotation = direction.angle()
	position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hurtbox"):
		_deal_damage_to(area)
		queue_free()

func _deal_damage_to(area: Area2D) -> void:
	var player = area.owner_player
	if player and not player.is_invincible:
		player.take_damage(damage, get_parent())
