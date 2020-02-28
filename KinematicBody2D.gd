extends KinematicBody2D

const UP = Vector2(0 ,-1)
const GRAVITY = 23
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -600

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Apple.flip_h = false
		$Apple.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Apple.flip_h = true
		$Apple.play("Run")
	else:
		$Apple.play("Idle")
		friction = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.3)
		elif Input.is_action_pressed("ui_down"):
			motion.y = GRAVITY * 10
		
	else:
		if motion.y < 0:
			$Apple.play("Jump")
		else: 
			$Apple.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.04)
	
	motion = move_and_slide(motion, UP)
	pass