extends KinematicBody2D
# rörelse script aka Zimonprostyle
const UP = Vector2(0, -1)
const Side = Vector2(-1, 0)
#bestämmer vad som är upp
export var motion = Vector2()
export var maxspeed = 600
export var gravity = 10
export var jump_force = -300
export var jump_force_grav = 600
export var acceleration = 50
export var SuperJump = -800
export var SuperJumpGrav = 1000
export var antigrav = false;
export var sidegrav = false;
export var UppOchNer = true;


func _physics_process(delta):
	var friction = false
	if UppOchNer == true:
		if antigrav == false:
			motion.y += gravity 
		elif antigrav == true:
			motion.y -= gravity
	elif UppOchNer == false:
		if sidegrav == false:
			motion.x += gravity
		elif sidegrav == true:
			motion.x -= gravity
#
	if UppOchNer == true:
		
		if Input.is_action_pressed("ui_right"):
			#motion.x += acceleration (finns i rad neranför)
			motion.x = min(motion.x+acceleration, maxspeed)
			$Sprite.flip_h = false
			$Sprite.play("Run")
			#höger vid piltryck (med acceleration)	
			#Sprite function som inte vänder karaktären och spelar "run" animation
		elif Input.is_action_pressed("ui_left"):
			$Sprite.flip_h = true
			$Sprite.play("Run")
			#motion.x -= acceleration (finns i rad neranför)
			#Sprite function som vänder karaktären och spelar "run" animation
			motion.x = max(motion.x-acceleration, -maxspeed)
			#vänsterr viid piltryck (med acceleration)
		else:
			friction = true
			$Sprite.play("Idle")
			#stanna om inget är intryckt (långsamt)
		if is_on_floor():
			if Input.is_action_just_released("ui_down"):
				motion.y = SuperJump
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
				$Sprite.play("Idle")
				
			if Input.is_action_just_pressed("ui_up"):
				motion.y = jump_force
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
				$Sprite.play("Idle")
		else:
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05)
				if antigrav == false:
					if motion.y < 0:
						$Sprite.play("Jump")
					else:
						$Sprite.play("Fall")
				else:
					antigrav == true
					if motion.y > 0: 
						$Sprite.play("Jump")
					else:
						$Sprite.play("Fall")
				
		if is_on_ceiling():
			if Input.is_action_just_released("ui_down"):
				motion.y = SuperJumpGrav
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
				$Sprite.play("Idle")
			if Input.is_action_just_pressed("ui_up"):
				motion.y = jump_force_grav
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
				$Sprite.play("Idle")
		#else:
		#	if friction == true:
		#		motion.x = lerp(motion.x, 0, 0.05)
		#		if motion.y > 0:
		#			$Sprite.play("Jump")
		#		else:
		#			$Sprite.play("Fall")
				
	
				
				#Hoppar med upp-pil
			
		motion = move_and_slide(motion, UP)
		#ser till att du kan röra på dig, och om du kör mot en väg glider ner längs med den (bland annat)
		
			
#Rörelse om if UppOchNer == false

#
#		if UppOchNer == true:
#			if antigrav == false:
#				motion.y += gravity 
#			elif antigrav == true:
#				motion.y -= gravity
#		elif UppOchNer == false:
#			if sidegrav == false:
#				motion.x += gravity
#			elif sidegrav == true:
#				motion.x -= gravity
	elif UppOchNer == false:
		if Input.is_action_pressed("ui_right"):
			#motion.x += acceleration (finns i rad neranför)
			motion.y = min(motion.y+acceleration, maxspeed)
			$Sprite.flip_h = false
			$Sprite.play("Run")
			#höger vid piltryck (med acceleration)	
			#Sprite function som inte vänder karaktären och spelar "run" animation
		elif Input.is_action_pressed("ui_left"):
			$Sprite.flip_h = true
			$Sprite.play("Run")
			#motion.x -= acceleration (finns i rad neranför)
			#Sprite function som vänder karaktären och spelar "run" animation
			motion.y = max(motion.y-acceleration, -maxspeed)
			#vänsterr viid piltryck (med acceleration)
		else:
			friction = true
			$Sprite.play("Idle")
			#stanna om inget är intryckt (långsamt)
		if is_on_wall():
			if Input.is_action_just_released("ui_down"):
				motion.x = SuperJump
			if friction == true:
				motion.y = lerp(motion.y, 0, 0.2)
				$Sprite.play("Idle")
				
			if Input.is_action_just_pressed("ui_up"):
				motion.x = jump_force
			if friction == true:
				motion.y = lerp(motion.y, 0, 0.2)
				$Sprite.play("Idle")
		else:
			if friction == true:
				motion.y = lerp(motion.y, 0, 0.05)
				if sidegrav == false:
					if motion.x < 0:
						$Sprite.play("Jump")
					else:
						$Sprite.play("Fall")
				else:
					sidegrav == true
					if motion.x > 0: 
						$Sprite.play("Jump")
					else:
						$Sprite.play("Fall")
				
		if is_on_wall():
			if Input.is_action_just_released("ui_down"):
				motion.x = SuperJumpGrav
			if friction == true:
				motion.y = lerp(motion.y, 0, 0.2)
				$Sprite.play("Idle")
			if Input.is_action_just_pressed("ui_up"):
				motion.x = jump_force_grav
			if friction == true:
				motion.y = lerp(motion.y, 0, 0.2)
				$Sprite.play("Idle")
				
				motion = move_and_slide(motion, Side)
		
		# här sker gravitations ändringar
func _on_AntiGravKropp_body_entered(body):
	if body.is_in_group("Spelare"): # && UppOchNer == false:
		UppOchNer = true
#	elif body.is_in_group("Spelare") && UppOchNer == true:
#		UppOchNer = false
		if body.is_in_group("Spelare") && antigrav == false: 
			antigrav = true;  #sätter gravityn till upp o ner
			$Sprite.flip_v = true
		elif body.is_in_group("Spelare") && antigrav == true:
			antigrav = false; #sätter gravityn tillbaka till standard
			$Sprite.flip_v = false

func _on_SideGravKropp_body_entered(body):
	if body.is_in_group("Spelare"): #&& UppOchNer == true:
		UppOchNer = false
	#elif body.is_in_group("Spelare") && UppOchNer == false:
	#	UppOchNer = true
		if body.is_in_group("Spelare") && sidegrav == false:
			sidegrav = true;
		elif body.is_in_group("Spelare") && sidegrav == true:
			sidegrav = false; 