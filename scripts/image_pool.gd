extends ItemList

var image_tiles = []

func _can_drop_data(at_position, data):
	return data.type == "files" or data.type == "image_tile"

func _drop_data(at_position, data):
	if data.type == "files":
		var files = data.files
		for file in files:
			var image_tile = ImageTile.new()
			image_tile.file_name = file
			image_tile.uid = OS.get_unique_id()
			add_image_tile(image_tile)
	elif data.type == "image_tile":
		add_image_tile(data.image_tile)

func add_image_tile(image_tile):
	image_tiles.append(image_tile)
	var texture = image_tile.get_texture()
	if texture:
		add_item(image_tile.file_name, texture)

func _get_drag_data(p_pos):
	var index = get_item_at_position(p_pos, true)
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

func add_item(text, icon):
	var item_index = get_item_count()
	super.add_item(text, icon)
