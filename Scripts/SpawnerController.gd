extends Node
export (Array, Resource) var spawn_objects  = [];

func spawn(spawner: Node):
	randomize();
	var obj = spawn_objects[rand_range(0, spawn_objects.size())];
	var instance = spawner.spawn(obj);
	print(instance)
	var _spawner = instance.find_node("Spawner");
	_spawner.connect("Spawn",self,"spawn");
