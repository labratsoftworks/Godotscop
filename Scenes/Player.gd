extends KinematicBody

var direction = Vector3()
var gravity = -20
var velocity = Vector3()
var movVelocity = Vector3()
var acceleration = 100
var deceleration = 50
var maxspeed = 400
var velX = 0.0
var velZ = 0.0
var absvelocity = 0.0
var velscale = 0.0

onready var sprite = get_node("sprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	direction = Vector3(0, 0, 0)
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	
	direction = direction.normalized()
	
	#acceleration X
	if direction.x > 0:
		if velX < maxspeed:
			velX += acceleration
	elif direction.x < 0:
		if velX > -maxspeed:
			velX -= acceleration
	else:
		if velX > deceleration:
			velX -= deceleration
		elif velX < -deceleration:
			velX += deceleration
		else:
			velX = 0
	#acceleration Z
	if direction.z > 0:
		if velZ < maxspeed:
			velZ += acceleration
	elif direction.z < 0:
		if velZ > -maxspeed:
			velZ -= acceleration
	else:
		if velZ > deceleration:
			velZ -= deceleration
		elif velZ < -deceleration:
			velZ += deceleration
		else:
			velZ = 0
	absvelocity = abs(velX) + abs(velZ)
	absvelocity = clamp(absvelocity, 0, maxspeed)
	
	#animate
	if absvelocity != 0:
		sprite.play("Run")
	else:
		sprite.play("Idle")
	
	movVelocity = Vector3(velX, 0, velZ).normalized()
	
	velocity.y += gravity * delta
	velocity.x = movVelocity.x * delta * absvelocity
	velocity.z = movVelocity.z * delta * absvelocity
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))