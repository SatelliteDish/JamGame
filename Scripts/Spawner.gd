extends Position2D

signal Spawn;

func _process(delta):
	if Input.is_action_just_pressed("MoveDown"):
		emit_signal("Spawn",self);

func spawn(res: Resource) -> Node:
	print("Spawn!");
	var obj = res.instance();
	var scene = get_tree().current_scene;
	scene.add_child(obj);
	obj.set_position(global_position);
	print(global_position)
	queue_free();
	return obj
