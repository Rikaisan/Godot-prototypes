extends Node2D

@export var mouse_range : int = 4
@export var confine_mouse : bool = false
@export var map : TileMap
@export var player : CharacterBody2D
@export var object_layer : int = 2
@export var debug : bool = false

var tile_size = 16
var offset : int = 8
var current_tile := Vector2i(0, 0)
var hovering_object = false
enum Interaction {BREAK, DIALOGUE}

func hover_object():
	$Normal.visible = false
	$Pulsing.visible = true
	hovering_object = true

func stop_hover():
	$Pulsing.visible = false
	$Normal.visible = true
	hovering_object = false

func get_current_tile_data(property):
	var data = map.get_cell_tile_data(object_layer, current_tile)
	if data:
		return data.get_custom_data(property)
	return null

func get_current_tile_interaction():
	return get_current_tile_data("interaction")

func check_tile():
	if get_current_tile_interaction():
		var name = get_current_tile_data("name")
		if name:
			$Pulsing/Tooltip.text = get_current_tile_data("name")
		else:
			$Pulsing/Tooltip.text = ""
		hover_object()
	else:
		stop_hover()

func _ready() -> void:
	mouse_range *= tile_size
	if not debug:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN if confine_mouse else Input.MOUSE_MODE_HIDDEN
	stop_hover()

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	if player:
		var mouse_delta = mouse_pos - player.global_position
		if mouse_delta.length() > mouse_range:
			mouse_pos = player.global_position + mouse_range * mouse_delta.normalized();
	
	current_tile = Vector2i(floor(mouse_pos.x / 16), floor(mouse_pos.y / 16))
	
	check_tile()
	
	if hovering_object:
		global_position = current_tile * tile_size + Vector2i(offset, offset)
	else:
		global_position = mouse_pos
	
func _input(event: InputEvent) -> void:
	if map and event.is_action_pressed("select"):
		var data = get_current_tile_interaction()
		if data and data.type == Interaction.BREAK:
			print("Breaking...")
			map.erase_cell(object_layer, current_tile)
