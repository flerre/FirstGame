extends Camera2D
var Zoom0 = Vector2(0.2, 0.2)
var Zoom1 = Vector2(0.3, 0.3)
var Zoom2 = Vector2(0.5, 0.5)
var Zoom3 = Vector2(0.8, 0.8) 
var Zoom4 = Vector2(1, 1)
var Zoom5 = Vector2(2, 2)
var Zoom6 = Vector2(3, 3)

func _physics_process(delta):

	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_s"):
		if rotating == true:
			set_rotating(false)
		elif rotating == false:
			set_rotating(true)
			
func _input(event):
	if event is InputEventMouseButton and event.is_action_pressed("ui_mouse_wheel_down"):
		
		if get_zoom() == Zoom5:
			set_zoom(Zoom6)
		elif get_zoom() == Zoom4: 
			set_zoom(Zoom5)
		elif get_zoom() == Zoom3:
			set_zoom(Zoom4)
		elif get_zoom() == Zoom2:
			set_zoom(Zoom3)
		elif get_zoom() == Zoom1:
			set_zoom(Zoom2)
		elif get_zoom() == Zoom0:
			set_zoom(Zoom1)

	if event is InputEventMouseButton and event.is_action_pressed("ui_mouse_wheel_up"):
		
		if get_zoom() == Zoom6:
			set_zoom(Zoom5)
		elif get_zoom() == Zoom5: 
			set_zoom(Zoom4)
		elif get_zoom() == Zoom4:
			set_zoom(Zoom3)
		elif get_zoom() == Zoom3:
			set_zoom(Zoom2)
		elif get_zoom() == Zoom2:
			set_zoom(Zoom1)
		elif get_zoom() == Zoom1:
			set_zoom(Zoom0)







#tween