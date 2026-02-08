extends Node

var image_pool

func _ready():
	image_pool = get_node("/root/Control/Panel/VBoxContainer/HBoxContainer/SidePanel_VBoxContainer/ImagePool_FoldableContainer/ImagePool_ItemList")

func open_file_dialog():
	var file_dialog = FileDialog.new()
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILES
	file_dialog.add_filter("*.png, *.jpg, *.jpeg")
	file_dialog.connect("files_selected", self, "_on_files_selected")
	add_child(file_dialog)
	file_dialog.popup_centered()

func _on_files_selected(files):
	for file in files:
		var image_tile = ImageTile.new()
		image_tile.file_name = file
		image_tile.uid = OS.get_unique_id()
		image_pool.add_image_tile(image_tile)
