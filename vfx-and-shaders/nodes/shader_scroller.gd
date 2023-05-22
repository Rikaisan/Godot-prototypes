extends Node2D

@export_enum("None", "Flash", "Shock", "Chromatic Aberration", "Grayscale", "Spider Vision", "Gradient", "Tone Remap", "Texture Distort")
var current_shader = 0
var target : ColorRect;
var label : Label;
@export var auto_change = true

func play_animation(name, duration):
	$ShaderController.play(name)
	await get_tree().create_timer(duration).timeout
	$ShaderController.stop()

func update_shader():
	match current_shader:
		0:
			label.text = "None"
			target.material = load("res://shaders/materials/shock_material.tres")
			if auto_change:
				await get_tree().create_timer(2.0).timeout
				current_shader += 1
				update_shader()
		1:
			label.text = "Flash"
			play_animation("flash", 1.5)
			if auto_change:
				await get_tree().create_timer(2.0).timeout
				current_shader += 1
				update_shader()
		2:
			label.text = "Shock"
			target.material = load("res://shaders/materials/shock_material.tres")
			play_animation("shock_animation", 1.5)
			if auto_change:
				await get_tree().create_timer(2.0).timeout
				current_shader += 1
				update_shader()
		3:
			label.text = "Chromatic Aberration"
			target.material = load("res://shaders/materials/chromatic_material.tres")
			if auto_change:
				await get_tree().create_timer(2.0).timeout
				current_shader += 1
				update_shader()
		4:
			label.text = "Grayscale [Red Channel]"
			target.material = load("res://shaders/materials/grayscale_material.tres")
			await get_tree().create_timer(2.0).timeout
			label.text = "Grayscale [Green Channel]"
			target.material.set_shader_parameter("method", 1)
			await get_tree().create_timer(2.0).timeout
			label.text = "Grayscale [Blue Channel]"
			target.material.set_shader_parameter("method", 2)
			await get_tree().create_timer(2.0).timeout
			label.text = "Grayscale [Average]"
			target.material.set_shader_parameter("method", 3)
			if auto_change:
				await get_tree().create_timer(2.0).timeout
				current_shader += 1
				update_shader()
		5:
			label.text = "Spider Vision"
			target.material = load("res://shaders/materials/spider_vision_material.tres")
			if auto_change:
				await get_tree().create_timer(2.0).timeout
				current_shader += 1
				update_shader()
		6:
			label.text = "Gradient Overlay"
			target.material = load("res://shaders/materials/gradient_material.tres")
			if auto_change:
				await get_tree().create_timer(2.0).timeout
				current_shader += 1
				update_shader()
		7:
			label.text = "Color Remapping [Off]"
			target.material = load("res://shaders/materials/remap_material.tres")
			await get_tree().create_timer(2.0).timeout
			label.text = "Color Remapping [On]"
			target.material.set_shader_parameter("remap_colors", true)
			if auto_change:
				await get_tree().create_timer(2.0).timeout
				current_shader += 1
				update_shader()
		8:
			label.text = "Screen Distortion [No Texture]"
			target.material = load("res://shaders/materials/distort_material.tres")
			await get_tree().create_timer(2.0).timeout
			label.text = "Screen Distortion [Cell Noise]"
			target.material.set_shader_parameter("noiseTexture", load("res://textures/cells_noise.tres"))
			await get_tree().create_timer(2.0).timeout
			label.text = "Screen Distortion [Standard Noise]"
			target.material.set_shader_parameter("noiseTexture", load("res://textures/normal_noise.tres"))
			await get_tree().create_timer(2.0).timeout
			label.text = "Screen Distortion [High Lacunarity]"
			target.material.set_shader_parameter("noiseTexture", load("res://textures/paint_noise.tres"))
			if auto_change:
				await get_tree().create_timer(2.0).timeout
				current_shader = 0
				update_shader()

func _ready() -> void:
	target = $CanvasLayer/CanvasShader
	label = $CanvasLayer/Label
	if not auto_change:
		update_shader()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if not auto_change:
			current_shader += 1
		update_shader()
