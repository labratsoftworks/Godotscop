extends Viewport

var maxsize = Vector2(240, 320)
var minsize = Vector2(120, 160)
var vp_size = Vector2(240, 320)
var speed = 10
var paused = false
onready var viewport = get_viewport()


func _process(delta):
	pass
	return
	if Input.is_action_pressed("Start"):
		paused = !paused
	if !paused:
		if vp_size.x < maxsize.x:
			vp_size.x += speed
		else: vp_size.x = maxsize.x
		if vp_size.y < maxsize.y:
			vp_size.y += speed
		else: vp_size.y = maxsize.y
	else:
		if vp_size.x > minsize.x:
			vp_size.x -= speed
		else: vp_size.x = minsize.x
		if vp_size.y > minsize.y:
			vp_size.y -= speed
		else: vp_size.y = minsize.y
	print(vp_size)
	viewport.set_size_override(true, vp_size)

