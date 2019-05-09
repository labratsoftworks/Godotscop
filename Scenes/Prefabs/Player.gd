extends KinematicBody
#movement
export var gravity = -20
export var acceleration = 30
export var deceleration = 35
export var maxspeed = 400
var direction = Vector3()
var velocity = Vector3()
var movVelocity = Vector3()
var velX = 0.0
var velZ = 0.0
var absvelocity = 0.0
var velscale = 0.0
#animation
export var facingdir = 0
#Sound
var iswalking = false
var walkSndTimer = 0
var leftstep = false
var step = false
export var timePerStepSound = 0.28
export var surface = 0
#GetComponenets
onready var sprite = get_node("sprite")
onready var grassL = get_node("grassL")
onready var grassR = get_node("grassR")
onready var stoneL = get_node("stoneL")
onready var stoneR = get_node("stoneR")
onready var floorL = get_node("floorL")
onready var floorR = get_node("floorR")
onready var groundray = get_node("groundray")

func _ready():
	walkSndTimer = timePerStepSound

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
	
	movVelocity = Vector3(velX, 0, velZ).normalized()
	
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += gravity * delta
	velocity.x = movVelocity.x * delta * absvelocity
	velocity.z = movVelocity.z * delta * absvelocity
	
	#dir calc
	if direction.x > 0: # right
		facingdir = 1
	elif direction.x < 0: # left
		facingdir = 3
	elif direction.z > 0: # forward
		facingdir = 0
	elif direction.z < 0: # back
		facingdir = 2
	#animate
	if direction != Vector3.ZERO:
		iswalking = true
		if facingdir == 0:
			sprite.play("f_walk")
		if facingdir == 1:
			sprite.play("r_walk")
		if facingdir == 2:
			sprite.play("b_walk")
		if facingdir == 3:
			sprite.play("l_walk")
	else:
		iswalking = false
		if facingdir == 0:
			sprite.play("f_idle")
		if facingdir == 1:
			sprite.play("r_idle")
		if facingdir == 2:
			sprite.play("b_idle")
		if facingdir == 3:
			sprite.play("l_idle")
	#move
	velocity = move_and_slide(velocity, Vector3.UP)
	#Ground ray
	if groundray.is_colliding():
		var other = groundray.get_collider()
		if other.is_in_group("grass"):
			surface = 0
		if other.is_in_group("stone"):
			surface = 1
		if other.is_in_group("floor"):
			surface = 2

func _process(delta):
	#step sound timer
	if iswalking:
		walkSndTimer -= delta
		if walkSndTimer <= 0:
			leftstep = !leftstep
			step = true
			walkSndTimer = timePerStepSound
	else:
		walkSndTimer = timePerStepSound
		leftstep = true
	#play sounds
	if step == true:
		#grass
		if surface == 0:
			if leftstep == true:
				grassL.play()
			else:
				grassR.play()
		#stone
		if surface == 1: 
			if leftstep == true:
				stoneL.play()
			else:
				stoneR.play()
		#floor
		if surface == 2:
			if leftstep == true:
				floorL.play()
			else:
				floorR.play()
	step = false