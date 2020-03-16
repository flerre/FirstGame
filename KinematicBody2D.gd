extends KinematicBody2D

const UP = Vector2(0 ,-1)
const GRAVITY = 25
export var ACCELERATION = 70
export var MAX_SPEED = 200
export var CROUCH_JUMP = -10
export var JUMP = -600
export var MAX_JUMPHEIGHT = -850
var CROUCH = 0
var COUNT = 0
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
			motion.y = JUMP
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.3)
		if Input.is_action_pressed("ui_down"):
			CROUCH == 1
			COUNT += 2
			
			$Apple.play("Fall")
			if Input.is_action_pressed("ui_right"):
				motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
			elif Input.is_action_pressed("ui_left"):
				motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
			
			
		else:
			pass
		if Input.is_action_just_released("ui_down"):
				motion.y = max(motion.y+COUNT * CROUCH_JUMP, MAX_JUMPHEIGHT)
				COUNT = 0
				CROUCH = 0
				
				
		
	else:
		if motion.y < 0:
			$Apple.play("Jump")
		else: 
			$Apple.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.04)
	
	motion = move_and_slide(motion, UP)
	pass