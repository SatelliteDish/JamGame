extends Node


export var SPEED = 100;
export var SPAWNX = 640;
export var DESTROYX = -1500;

signal Reverse;
signal ChangeSpeed;

var reversed = false;


func set_reverse(status: bool):
	reversed = status;
	emit_signal("Reverse", status);
	
func set_speed(speed: float):
	speed = SPEED;
	emit_signal("ChangeSpeed", speed);
	
func give_ground_settings(ground: KinematicBody2D) -> KinematicBody2D:
	ground.SPEED = SPEED;
	ground.reversed = reversed;
	ground.spawnX = SPAWNX;
	ground.destroyX = DESTROYX;
	return ground;
