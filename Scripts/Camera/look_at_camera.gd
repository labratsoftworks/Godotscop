extends AnimatedSprite3D
export var lockZ = true
var camera_pos = Vector3()
func _process(delta):
	camera_pos = get_viewport().get_camera().global_transform.origin
	if lockZ:
		camera_pos.z = camera_pos.z + 1000
	look_at(camera_pos, Vector3.UP)
