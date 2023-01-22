extends KinematicBody2D

enum {
	MOVE,
}

export var ACCELERATION = 100;
export var MAX_SPEED = 200;
export var FRICTION = 100;
export var GRAVITY = 100;

var velocity: Vector2 = Vector2.ZERO;
var input_vector: Vector2 = Vector2.ZERO;

var state = MOVE;

func _physics_process(delta):
	input_vector.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft");
	input_vector.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp");
	
	match state:
		MOVE:
			move_state(delta);

func move():
	velocity.y += GRAVITY;
	velocity = move_and_slide(velocity);

func move_state(delta):
	velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta);
	move();

#bug booty
