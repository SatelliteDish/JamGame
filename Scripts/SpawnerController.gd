extends Node
export (Array, Resource) var spawn_objects  = [];
onready var groundController = get_node("../GroundController");

func _ready():
	print(groundController)

func spawn(spawner: Node):
	randomize();
	var obj = spawn_objects[rand_range(0, spawn_objects.size())];
	var instance = spawner.spawn(obj);
	instance.add_ground_controller(groundController);
	var _spawner = instance.find_node("Spawner");
	_spawner.connect("Spawn",self,"spawn");
