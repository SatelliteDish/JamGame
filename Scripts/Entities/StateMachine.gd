extends Node

enum State {
	MOVE,
	JUMP,
	DEAD,
}

export var InputHandler: NodePath = "";

onready var inputHandler = get_node(InputHandler);

signal StateChanged;

var state = State.MOVE setget state_changed;
var queue = [];

func _ready():
	inputHandler.connect("JumpPressed",self,"jump_pressed");

func state_changed(var _state):
	state = _state;
	var stateString: String = "";
	match state:
		State.MOVE:
			stateString = "MOVE";
		State.JUMP:
			stateString = "JUMP";
		State.DEAD:
			stateString = "DEAD";
		
	emit_signal("StateChanged", stateString);
	
func _process(delta):
	if state == State.MOVE && queue.size() != 0:
		state_changed(queue.pop_front());
	
func state_complete():
	if queue.size() == 0:
		state_changed(State.MOVE);
	else:
		state = queue.pop_front();

func jump_pressed():
	print("Jump Received");
	queue.push_back(State.JUMP);
	pass;
