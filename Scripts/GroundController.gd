extends Node


signal Reverse;
signal ChangeSpeed;

var reversed = false;

func _process(delta):
	if Input.is_action_just_pressed("MoveUp"):
		reversed = !reversed;
		set_reverse(reversed);

func set_reverse(status: bool):
	emit_signal("Reverse", status);
	
func set_speed(speed: float):
	emit_signal("ChangeSpeed", speed);
