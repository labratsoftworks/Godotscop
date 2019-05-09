extends KinematicBody
export var followDistance = 3
export (NodePath) var targetPath
var currentpos = Vector3()
var velocity = Vector3()
var dir = Vector3()
func _ready():
	pass

func _physics_process(delta):
	var targetpos = get_node(targetPath).get_translation()
	currentpos = self.get_translation()
	var xdistance = targetpos.x - currentpos.x
	#xFollow
	xdistance = abs(xdistance)
	if xdistance >= followDistance:
		if currentpos.x > targetpos.x:
			dir.x = -(xdistance - followDistance)
		elif currentpos.x < targetpos.x:
			dir.x = (xdistance - followDistance)
		else:
			dir.x = 0
	else:
		dir.x = 0
	#Z follow
	var zdistance = targetpos.z - currentpos.z
	zdistance = abs(zdistance)
	if zdistance >= followDistance:
		if currentpos.z > targetpos.z:
			dir.z = -(zdistance - followDistance)
		elif currentpos.z < targetpos.z:
			dir.z = (zdistance - followDistance)
		else:
			dir.z = 0
	else:
		dir.z = 0
	set_translation(currentpos + dir)
	#move_and_slide(dir * speed, Vector3(0, 1, 0))