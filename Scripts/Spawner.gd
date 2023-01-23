extends Position2D

signal Spawn;

export var start: bool = false;

var spawned = false;

func get_request():
	if !spawned:
		emit_signal("Spawn",self);

func spawn(res: Resource) -> Node:
	if spawned:
		return null;
	spawned = true;
	var obj = res.instance();
	var scene = get_tree().current_scene;
	scene.add_child(obj);
	obj.set_position(global_position);
	return obj
