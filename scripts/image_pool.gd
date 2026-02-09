class_name ImagePoolItemList
extends ItemList

var image_tiles = []

func _can_drop_data(at_position, data):
	return (
		data.type == "files"
		# or data.type == "image_tile"
		)

func _drop_data(at_position, data):
	if data.type == "files":
		var files = data.files
		for file in files:
			var image_tile = ImageTile.new()
			image_tile.file_name = file
			image_tile.uid = OS.get_unique_id()
			add_image_tile(image_tile)
	elif data.type == "image_tile":
		pass
		# TODO ? catch and filter drops duplicating items from itself.
		#add_image_tile(data.image_tile)

func add_image_tile(image_tile):
	image_tiles.append(image_tile)
	var texture = image_tile.get_texture()
	if texture:
		_add_item(image_tile.file_name, texture)

func _get_drag_data(p_pos):
	print("_get_drag_data: %v" %p_pos)
	var index = get_item_at_position(p_pos, true)
	print("	index: %d" %index)
	if index != -1:
		var image_tile = image_tiles[index]
		var data = {}
		data.type = "image_tile"
		data.image_tile = image_tile

		var preview = TextureRect.new()
		preview.texture = image_tile.get_texture()
		preview.size = Vector2(64, 64)
		set_drag_preview(preview)

		return data
	return null

func _add_item(text:String, icon:Texture2D=null, selectable:bool=true):
	var item_index = get_item_count()
	super.add_item(text, icon, selectable)
