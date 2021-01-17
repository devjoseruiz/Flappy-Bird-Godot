extends RigidBody2D

class_name Player

const MAX_ROTATION_DEGREES = -35.0

export var flap_force = -200
onready var animator = $AnimationPlayer
var started = false

func start():
	gravity_scale = 5.0
	animator.play("flap")
	started = true

func flap():
	linear_velocity.y = flap_force
	angular_velocity = -5.0

func die():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("flap"):
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
