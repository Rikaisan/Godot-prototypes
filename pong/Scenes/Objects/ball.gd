extends RigidBody2D

@export var speed = 300
var start_position
var velocity
# var starting_angles = [30, 45, 135, 150, 210, 225, 315, 330]
var starting_angles = [45, 135, 225, 315]

func _ready():
	start_position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
	reset()

func _on_arena_start_game():
	var angle = deg_to_rad(starting_angles[randi() % starting_angles.size()])
	velocity = Vector2(cos(angle) * speed, sin(angle) * speed)

func _physics_process(delta):
	if velocity:
		var other = move_and_collide(velocity * delta)
		if other:
			velocity = velocity.bounce(other.get_normal())

func reset():
	position = start_position
	velocity = Vector2.ZERO


func _on_score_zone_body_entered(body):
	if body.is_in_group("ball"):
		reset()
