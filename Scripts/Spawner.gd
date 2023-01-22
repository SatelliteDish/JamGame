extends Position2D

signal Spawn;

export var start: bool = false;

func _ready():
	if start: 
		get_request();

func get_request():
	emit_signal("Spawn",self);

func spawn(res: Resource) -> Node:
	var obj = res.instance();
	var scene = get_tree().current_scene;
	scene.add_child(obj);
	obj.set_position(global_position);
	queue_free();
	return obj
