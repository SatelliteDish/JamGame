extends KinematicBody2D

export var GRAVITY = 100;
export var MAXSPEED = 100;
export var FRICTION = 150;
export var JUMPHEIGHT = 200;
export var SPEED = 100;

var currentSpeed = 0.0;
var velocity: Vector2 = Vector2.ZERO;

onready var stateMachine = $StateMachine;
onready var state = "MOVE";

func _ready():
	stateMachine.connect("StateChanged",self,"on_state_changed");
	
func _physics_process(delta):
	match state:
		"IDLE":
			idle_state(delta);
		"JUMP":
			jump_state();
		"MOVELEFT":
			move_state(-SPEED, delta);
		"MOVERIGHT":
			move_state(SPEED, delta);
		_:
			stateMachine.state_complete();
	move(delta);

func move_state(speed: float, delta: float):
	velocity = velocity.move_toward(Vector2(MAXSPEED, velocity.y), speed * delta);
	
func idle_state(delta: float):
	velocity = velocity.move_toward(Vector2(0, velocity.y), FRICTION * delta);

func move(delta):
	velocity.y += GRAVITY;
	velocity = move_and_slide(velocity);

func jump_state():
	velocity.y -= JUMPHEIGHT; 
	stateMachine.state_complete();

func on_state_changed(_state: String):
	state = _state;
