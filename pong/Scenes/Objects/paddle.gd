extends AnimatableBody2D

@export var is_player = false
@export var speed = 100

@export var controls = ["p1_up", "p1_down"]

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_player:
		if Input.is_action_pressed(controls[0]):
			move_and_collide(Vector2(0, -speed * delta))
		if Input.is_action_pressed(controls[1]):
			move_and_collide(Vector2(0, speed * delta))
	else:
		var ball = get_tree().get_nodes_in_group("ball")[0]
		if ball:
			var ball_y = ball.position.y
			if ball_y < position.y:
				move_and_collide(Vector2(0, -speed * delta))
			elif ball_y > position.y:
				move_and_collide(Vector2(0, speed * delta))

func reset():
	position = Vector2(position.x, get_viewport_rect().size.y / 2)


func _on_score_zone_body_entered(body):
	if body.is_in_group("ball"):
		reset()
