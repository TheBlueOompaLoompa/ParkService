extends CharacterBody3D

@onready var camera = $Camera3D

@export var move_speed = 3.0
@export var jump_velocity = 5.0
@export var look_speed = 1.0
@export var max_look_angle = 80.0
@export var min_look_angle = -80.0

func _ready():
    DisplayServer.mouse_set_mode(DisplayServer.MouseMode.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("menu"):
        DisplayServer.mouse_set_mode(DisplayServer.MouseMode.MOUSE_MODE_VISIBLE)
    if event.is_action_pressed("place"):
        DisplayServer.mouse_set_mode(DisplayServer.MouseMode.MOUSE_MODE_CAPTURED)
    if event is InputEventMouseMotion:
        rotation.y -= event.relative.x / 180 * PI * look_speed
        camera.rotation.x = maxf(minf(camera.rotation.x - event.relative.y / 180.0 * PI * look_speed, max_look_angle / 180 * PI), min_look_angle / 180 * PI)

func _on_terrain_finished(terrain: Terrain):
    $HUD.make_mini(terrain.biome_image)


var target_velocity = Vector3.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    # Handle jump.
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
    var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    if direction:
        velocity.x = direction.x * move_speed
        velocity.z = direction.z * move_speed
    else:
        velocity.x = move_toward(velocity.x, 0, move_speed)
        velocity.z = move_toward(velocity.z, 0, move_speed)

    move_and_slide()

    $HUD.player_pos(global_position)
