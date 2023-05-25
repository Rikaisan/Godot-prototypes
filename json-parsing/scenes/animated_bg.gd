extends ColorRect

@export var speed_multiplier : float = 0.25

var elements

func _ready() -> void:
	elements = get_children()
	var new_elements = []
	for element in elements:
		var mode = randi_range(0, 1)
		new_elements.append([element, randf_range(PI, TAU) if mode else randf_range(-PI, -TAU)])
	elements = new_elements


func _process(delta: float) -> void:
	for element in elements:
		element[0].rotation += element[1] * delta * speed_multiplier
