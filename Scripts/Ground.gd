extends KinematicBody2D

onready var spawner = $Spawner;

var groundController: Node = null setget add_ground_controller;
var velocity: Vector2 = Vector2.ZERO;
var SPEED: float = 100; 
var reversed: bool = false;
var hasSpawned: bool = false;
var spawnX = 640.0;
var destroyX = -1000;

func add_ground_controller(controller: Node):
	groundController = controller;
	groundController.connect("Reverse",self,"reverse");
	groundController.connect("ChangeSpeed",self,"change_speed");
	pass;

func _physics_process(delta):
	if global_position.x < spawnX && !hasSpawned:
		spawner.get_request();
		hasSpawned = true;
	if global_position.x < destroyX:
		queue_free();
	velocity.x = -SPEED;
	if reversed:
		velocity *= -1;
	move_and_slide(velocity);
	
func reverse(status: bool):
	reversed = status;

func change_speed(speed: float):
	SPEED = speed;
