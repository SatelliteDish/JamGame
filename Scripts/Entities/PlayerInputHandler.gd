extends Node

var input_vector: Vector2 = Vector2.ZERO;

signal InputVectorChanged;

func _process(delta):
	var new_vec = Vector2.ZERO;
	new_vec.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft");
	new_vec.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp");
	if new_vec == input_vector:
		return;
	input_vector = new_vec;
	emit_signal("InputVectorChanged", input_vector);
