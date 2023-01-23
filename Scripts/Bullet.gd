extends KinematicBody2D

export var SPEED = 5;

onready var velocity: Vector2 = Vector2(SPEED,0);

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta);
	if collision != null:
		_break(collision.get_collider());

func _break(obj: Object):
	queue_free()
	pass
