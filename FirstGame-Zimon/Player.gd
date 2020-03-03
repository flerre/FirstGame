extends KinematicBody2D
# rörelse script aka Zimonprostyle
const Up = Vector2(0, -1)
const Side = Vector2(-1, 0)
#bestämmer vad som är upp
export var Motion = Vector2()
export var Maxspeed = 500
export var Gravity = 10
export var JumpForce = -400
export var AntiJumpForce = 400
export var Acceleration = 70
export var SuperJump = -800
export var SuperJumpGrav = 1000
export var AntiGrav = false;
export var SideGrav = false;
export var UppONer = true;


func _physics_process(delta):
	var Friction = false
	if UppONer == true:
		SideGrav = false
		if AntiGrav == false:
			Motion.y += Gravity 
		elif AntiGrav == true:
			Motion.y -= Gravity
	elif UppONer == false:
		AntiGrav = false
		if SideGrav == false:
			Motion.x += Gravity
		elif SideGrav == true:
			Motion.x -= Gravity

	Motion = move_and_slide(Motion, Up)
	if UppONer == true:
		set_rotation_degrees(0)
	elif UppONer == false:
		set_rotation_degrees(270)
		
	if UppONer == true:
		if Input.is_action_pressed("ui_right"):#Höger knapptryck movement med AntiGrav
			$Sprite.play("Run")
			if AntiGrav == false: 
				Motion.x = min(Motion.x+Acceleration, Maxspeed)
				$Sprite.flip_h = false
			elif AntiGrav == true:
				Motion.x = max(Motion.x-Acceleration, -Maxspeed)
				$Sprite.flip_h = true
		elif Input.is_action_pressed("ui_left"):#Vänster Knapptryck movement med AntiGrav
			$Sprite.play("Run")
			if AntiGrav == false:  
				Motion.x = max(Motion.x-Acceleration, -Maxspeed)
				$Sprite.flip_h = true
			elif AntiGrav == true:
				Motion.x = min(Motion.x+Acceleration, Maxspeed)
				$Sprite.flip_h = false
		else:                                  #När man står stilla med Animated flip för AntiGrav
			Friction = true
			$Sprite.play("Idle")
			#if AntiGrav == true:
			#	$Sprite.flip_h = true
				
		if is_on_floor() && AntiGrav == false:
			if Input.is_action_just_pressed("ui_up"):
				Motion.y = JumpForce
			if Friction == true:
				Motion.x = lerp(Motion.x, 0, 0.2)
				$Sprite.play("Idle")
		else:
			if Friction == true: 
				Motion.x = lerp(Motion.x, 0, 0.05)
				if Motion.y < 0:
					$Sprite.play("Jump")
				if Motion.y > 0:
					$Sprite.play("Fall")
		if is_on_ceiling() && AntiGrav == true:
			if Input.is_action_just_pressed("ui_up"):
				Motion.y = AntiJumpForce
			if Friction == true:
				Motion.x = lerp(Motion.x, 0, 0.2)
				$Sprite.play("Idle")
			else: 
				if Friction == true:
					Motion.x = lerp(Motion.x, 0, 0.05)
					if Motion.y > 0:
						$Sprite.play("Jump")
					if Motion.y < 0:
						$Sprite.play("Fall")
		
	elif UppONer == false:
		if Input.is_action_pressed("ui_right"):
			$Sprite.play("Run")
			if SideGrav == false:
				Motion.y = max(Motion.y-Acceleration, -Maxspeed)
				$Sprite.flip_h = false
			elif SideGrav == true:
				Motion.y = min(Motion.y+Acceleration, Maxspeed)
				$Sprite.flip_h = true
		elif Input.is_action_pressed("ui_left"):
			$Sprite.play("Run")
			if SideGrav == false: 
				Motion.y = min(Motion.y+Acceleration, Maxspeed)
				$Sprite.flip_h = true
			elif SideGrav == true:
				Motion.y = max(Motion.y-Acceleration, -Maxspeed)
				$Sprite.flip_h = false
		else:
			Friction = true
			$Sprite.play("Idle")
#			if SideGrav == true:
#				$Sprite.flip_h = true
		if is_on_wall():
			if Input.is_action_just_pressed("ui_up"):
				if SideGrav == false: 
					Motion.x = JumpForce
					if Motion.y > 0:
						$Sprite.play("Jump")
					if Motion.y < 0:
						$Sprite.play("Fall")
				elif SideGrav == true:
					Motion.x = AntiJumpForce
					if Motion.y < 0:
						$Sprite.play("Jump")
					if Motion.y > 0:
						$Sprite.play ("Fall")
				if Friction == true: 
					Motion.y = lerp(Motion.y, 0, 0.2)
			else:
				if Friction == true:
					Motion.y = lerp(Motion. y, 0, 0.05)
				
		
		# här sker gravitations ändringar
func _on_AntiGravKropp_body_entered(body):
	if body.is_in_group("Spelare"): # && UppOchNer == false:
		UppONer = true
#	elif body.is_in_group("Spelare") && UppOchNer == true:
#		UppOchNer = false
		if body.is_in_group("Spelare") && AntiGrav == false: 
			AntiGrav = true;  #sätter gravityn till upp o ner
			$Sprite.flip_v = true
		elif body.is_in_group("Spelare") && AntiGrav == true:
			AntiGrav = false; #sätter gravityn tillbaka till standard
			$Sprite.flip_v = false

func _on_SideGravKropp_body_entered(body):
	if body.is_in_group("Spelare"): #&& UppOchNer == true:
		UppONer = false
	#elif body.is_in_group("Spelare") && UppOchNer == false:
	#	UppOchNer = true
		if body.is_in_group("Spelare") && SideGrav == false:
			SideGrav = true;
			$Sprite.flip_v = true
		elif body.is_in_group("Spelare") && SideGrav == true:
			SideGrav = false;
			$Sprite.flip_v = false
