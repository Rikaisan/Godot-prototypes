extends Control

@export var table_folder : String

var tables : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Fetch files
	var files = []
	var dir = DirAccess.open(table_folder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print('Found dir: ' + file_name)
			else:
				print('Found file: ' + file_name)
				files.append(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	# Load tables
	for file in files:
		var table = FileAccess.get_file_as_string(table_folder + file)
		table = JSON.parse_string(table)
		tables[table.name] = table

func roll_table(table_name : String) -> String:
	var table = tables[table_name]
	if table == null:
		print("Tried loading a non-existent table: " + table_name)
		return ""
	
	var total_weight : int = 0
	for item in table["items"]:
		total_weight += item["weight"]
	
	var dice_roll : int = randi_range(1, total_weight)
	
	print("total_weight: " + str(total_weight) + ", dice: " + str(dice_roll))
	
	var roll_weight = 0
	
	for item in table["items"]:
		roll_weight += item["weight"]
		if roll_weight >= dice_roll:
			if not item.has("type") or item["type"] == "item":
				return item["value"]
			elif item["type"] == "table":
				return roll_table(item["value"])
			else:
				print("Tried to roll invalid item: " + item)
				break
	print("Item out of range[dice, roll_weight]: {0}, {1}".format([str(dice_roll), str(roll_weight)]))
	return ""


func _on_button_pressed() -> void:
	var item = roll_table("fruits")
	if item:
		$Label.text = item
	else:
		$Label.text = "Invalid item, check console"
