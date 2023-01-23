extends KinematicBody2D

const Bullet = preload("res://Entities/Bullet.tscn"); 

export var GRAVITY = 10;
export var MAXSPEED = 100;
export var FRICTION = 150;
export var JUMPHEIGHT = 200;
export var SPEED = 100;
export var BULLETCOOLDOWN: float = .5;

var velocity: Vector2 = Vector2.ZERO;
var state: String = "IDLE";
var canShoot: bool = true;

onready var stateMachine = $StateMachine;
onready var bulletSpawn = $BulletSpawn

func _ready():
	stateMachine.connect("StateChanged",self,"on_state_changed");
	
func _physics_process(delta):
	match state:
		"IDLE":
			idle_state(delta);
		"JUMP":
			jump_state();
		"MOVELEFT":
			move_left(delta);
		"MOVERIGHT":
			move_right(delta);
		"SHOOT":
			shoot();
			stateMachine.state_complete();
	apply_friction();
	apply_gravity();
	move(delta);

func apply_gravity():
	velocity.y += GRAVITY;

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION);

func move(delta):
	velocity = move_and_slide(velocity, Vector2.UP);


func move_left(delta: float):
	velocity = velocity.move_toward(Vector2(-MAXSPEED, velocity.y), SPEED * delta);

func move_right(delta: float):
	velocity = velocity.move_toward(Vector2(MAXSPEED, velocity.y), SPEED * delta);

func idle_state(delta: float):
	pass;

func shoot():
	if !canShoot:
		return;
	canShoot = false;
	var bullet = Bullet.instance();
	get_tree().current_scene.add_child(bullet);
	bullet.global_position = bulletSpawn.global_position;
	yield(get_tree().create_timer(BULLETCOOLDOWN), "timeout");
	canShoot = true;

func jump_state():
	if is_on_floor():
		velocity.y -= JUMPHEIGHT;
	stateMachine.state_complete();

func on_state_changed(_state: String):
	state = _state;
