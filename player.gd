extends CharacterBody3D

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var mouse_sensitivity := 0.001
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	#if event is InputEventMouseMotion:
		#print(event.relative)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * mouse_sensitivity)
			camera.rotate_x(-event.relative.y * mouse_sensitivity)
			
			camera.rotation.x = clamp(
				camera.rotation.x,
				deg_to_rad(-30),
				deg_to_rad(60)
			)
	#if event is InputEventMouseButton:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#elif event.is_action_pressed("ui_cancel"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#if event is InputEventMouseMotion:
			#neck.rotate_y(-event.relative.x * 0.01)
			#camera.rotate_x(-event.relative.y * 0.01)
			#camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))

# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	#var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#veloc
	#var input := Vector3.ZERO
	#input.x = Input.get_axis("move_left", "move_right")
	#input.z = Input.get_axis("move_forward", "move_back")
	#
	#apply_central_force(input * 1200.0 * delta)
	
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()
		
