class_name ImageLoaderNode
extends Node

@onready var image_pool: ImagePoolItemList = %ImagePool_ItemList
@onready var mb_pop_file: PopupMenu = %MenuBar/File
@onready var artboard: Artboard = %Artboard

func _ready():
	mb_pop_file.id_pressed.connect(func(id):
		match id:
			0: open_file_dialog()
		)
	get_tree().root.files_dropped.connect(_on_files_dropped)
	
func _on_files_dropped(files: PackedStringArray):
	var valid_paths = []
	print("Dropped files:")
	for file_path in files:
		print(file_path)
		if file_path.ends_with(".png") or file_path.ends_with(".jpg"):
			valid_paths.append(file_path)
	_on_files_selected(PackedStringArray(valid_paths))

func open_file_dialog():
	var file_dialog = FileDialog.new()
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILES
	file_dialog.add_filter("*.png, *.jpg, *.jpeg")
	file_dialog.files_selected.connect(_on_files_selected)
	add_child(file_dialog)
	file_dialog.popup_centered()

func _on_files_selected(files:PackedStringArray):
	for file in files:
		var image_tile = ImageTile.new()
		image_tile.file_name = file
		image_tile.uid = OS.get_unique_id()
		print(image_tile.uid)
		image_pool.add_image_tile(image_tile)
