extends Camera
export var offset = Vector3(0, 2, 10)
export var xclamped = true
export var xrange = Vector2(10, 10)
export var zclamped = false
export var zrange = Vector2(10, 10)
export (NodePath) var targetPath
var pos = Vector3()

func _physics_process(delta):
	var targetpos = get_node(targetPath).get_translation()
	pos = offset + targetpos
	if xclamped:
		pos.x = clamp(pos.x, xrange.x, xrange.y)
	if zclamped:
		pos.z = clamp(pos.z, zrange.x, zrange.y)
	set_translation(pos)
