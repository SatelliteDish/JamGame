extends Node

enum State {
	IDLE,
	MOVELEFT,
	MOVERIGHT,
	JUMP,
	SHOOT,
	DEAD,
}
export var BUFFERCOUNT = 1;
export var InputHandler: NodePath = "";
export var randomized: bool = true;
export onready var randomMin: float = 7;
export onready var randomMax: float = 15;

onready var inputHandler = get_node(InputHandler);

var input_vector: Vector2 = Vector2.ZERO;

signal StateChanged;

var state = State.IDLE setget state_changed;
var queue = [];
var xReversed: bool = false;
var yReversed: bool = false;

func _ready():
	inputHandler.connect("InputVectorChanged",self,"input_vector_changed");
	var timer = get_tree().create_timer(randomMin,randomMax);
	timer.connect("timeout",self,"randomize_inputs");
	
func input_vector_changed(vec: Vector2):
	if xReversed && randomized:
		vec.x *= -1;
	if yReversed && randomized:
		vec.y *= -1;
	input_vector = vec;
	if abs(input_vector.y) == 1:
		match input_vector.y:
			-1.0:
				change_state(State.JUMP);
			1.0:
				change_state(State.SHOOT);
	elif abs(input_vector.x) == 1:
		match input_vector.x:
			-1.0:
				change_state(State.MOVELEFT);
			1.0:
				change_state(State.MOVERIGHT);
	elif input_vector == Vector2.ZERO:
		change_state(State.IDLE);

func change_state(var _state):
	if queue.size() >= BUFFERCOUNT:
		queue.pop_back();
	queue.push_back(_state);

func state_changed(var _state):
	if state == State.IDLE && _state == State.IDLE:
		return;
	state = _state;
	var stateString: String = "";
	match state:
		State.IDLE:
			stateString = "IDLE";
		State.MOVELEFT:
			stateString = "MOVELEFT";
		State.MOVERIGHT:
			stateString = "MOVERIGHT";
		State.JUMP:
			stateString = "JUMP";
		State.SHOOT:
			stateString = "SHOOT";
		State.DEAD:
			stateString = "DEAD";
	emit_signal("StateChanged", stateString);
	
func randomize_inputs():
	randomize();
	var length = rand_range(randomMin,randomMax);
	var timer = get_tree().create_timer(length);
	timer.connect("timeout",self,"randomize_inputs");
	randomize();
	var rand = randi();
	match rand % 2:
		0:
			toggle_x_reversed();
		1:
			toggle_y_reversed();

func toggle_y_reversed():
	yReversed = !yReversed;

func toggle_x_reversed():
	xReversed = !xReversed;


func _process(delta):
	var stateIsCancellable = (state == State.IDLE || state == State.MOVELEFT || state == State.MOVERIGHT);
	if stateIsCancellable && queue.size() != 0:
		state_changed(queue.pop_front());
	
func state_complete():
	if queue.size() == 0:
		state_changed(State.IDLE);
	else:
		state = queue.pop_front();
