@tool
extends ColorRect

@export_enum("Circle", "Square", "Line") var shader_shape = 0;

func _process(_delta: float) -> void:
	material.set_shader_parameter("shape_type", shader_shape)
