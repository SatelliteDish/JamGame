extends KinematicBody2D

enum {
	MOVE,
}

export var ACCELERATION = 100;
export var MAX_SPEED = 200;
export var FRICTION = 100;
export var GRAVITY = 100;
export var JUMPHEIGHT = 1000;

var velocity: Vector2 = Vector2.ZERO;
var input_vector = Vector2.ZERO;

onready var stateMachine = $StateMachine;
onready var inputHandler = $PlayerInputHandler;
onready var state = "MOVE";

func _ready():
	stateMachine.connect("StateChanged",self,"on_state_changed");
	inputHandler.connect("InputVectorChanged",self,"input_vector_changed");
	
func _physics_process(delta):
	match state:
		"MOVE":
			move_state(delta);
		"JUMP":
			jump_state();

func move():
	velocity.y += GRAVITY;
	velocity = move_and_slide(velocity);

func move_state(delta):
	velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta);
	move();

func jump_state():
	velocity.y -= JUMPHEIGHT; 
	stateMachine.state_complete();

func on_state_changed(_state: String):
	print("State changed to " + _state);
	state = _state;

func input_vector_changed(var vector: Vector2):
	input_vector = vector;
