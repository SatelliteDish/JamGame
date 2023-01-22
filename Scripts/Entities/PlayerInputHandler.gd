extends Node

var input_vector: Vector2 = Vector2.ZERO;

signal InputVectorChanged;
signal JumpPressed;

func _process(delta):
	input_vector.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft");
	input_vector.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp");
	
	if Input.is_action_just_pressed("Jump"):
		print("JumpSignalled");
		emit_signal("JumpPressed");
	
	emit_signal("InputVectorChanged", input_vector);
