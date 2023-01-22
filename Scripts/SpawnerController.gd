extends Node
export (Array, Resource) var spawn_objects  = [];
onready var groundController = get_node("../GroundController");

func spawn(spawner: Node):
	randomize();
	var obj = spawn_objects[rand_range(0, spawn_objects.size())];
	var instance = spawner.spawn(obj);
	instance.add_ground_controller(groundController);
	instance = groundController.give_ground_settings(instance);
	var _spawner = instance.find_node("Spawner");
	_spawner.connect("Spawn",self,"spawn");
