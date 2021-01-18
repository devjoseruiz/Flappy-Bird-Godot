extends RigidBody2D

class_name Player

signal died

const MAX_ROTATION_DEGREES = -35.0

export var flap_force = -250
onready var animator = $AnimationPlayer
onready var wing = $Wing
onready var dead = $Dead
onready var hit = $Hit

var started = false
var alive = true

func start():
	gravity_scale = 5.0
	animator.play("flap")
	started = true

func flap():
	linear_velocity.y = flap_force
	angular_velocity = -5.0
	wing.play()

func die():
	if not alive: return
	alive = false
	animator.stop()
	hit.play()
	dead.play()
	emit_signal("died")

func _physics_process(delta):
	if Input.is_action_just_pressed("flap") && alive:
		if not started:
			start()
		flap()
		
	if rotation_degrees <= MAX_ROTATION_DEGREES:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION_DEGREES
		
	if linear_velocity.y > 0:
		if rotation_degrees <= 90:
			angular_velocity = 2
		else:
			angular_velocity = 0
	
	for body in get_colliding_bodies():
		if body.get_name() == "Ground":
			die()
