extends KinematicBody2D

export var SPEED: float = 100;

var groundController: Node = null setget add_ground_controller;

var velocity: Vector2 = Vector2.ZERO; 
var reversed: bool = false;

func add_ground_controller(controller: Node):
	groundController = controller;
	groundController.connect("Reverse",self,"reverse");
	groundController.connect("ChangeSpeed",self,"change_speed");
	pass;

func _physics_process(delta):
	velocity.x = -SPEED;
	if reversed:
		velocity *= -1;
	move_and_slide(velocity);
	
func reverse(status: bool):
	reversed = status;

func change_speed(speed: float):
	SPEED = speed;
