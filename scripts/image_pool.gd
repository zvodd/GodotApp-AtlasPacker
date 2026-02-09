class_name ImagePoolItemList
extends ItemList

var image_tiles = []


func add_image_tile(image_tile):
	image_tiles.append(image_tile)
	var texture = image_tile.get_texture()
	if texture:
		_add_item(image_tile.file_name, texture)

func _get_drag_data(p_pos):
	print("_get_drag_data: %v" %p_pos)
	var index = get_item_at_position(p_pos, true)
	if index != -1:
		var image_tile = image_tiles[index]
		var data = {}
		data.type = "image_tile"
		data.image_tile = image_tile

		var preview = TextureRect.new()
		preview.expand_mode = 1
		preview.texture = image_tile.get_texture()
		preview.size = Vector2(min(64, preview.texture.get_width()), min(64, preview.texture.get_height()))
		set_drag_preview(preview)

		return data
	return null

func _add_item(text:String, icon:Texture2D=null, selectable:bool=true):
	#var item_index = get_item_count()
	super.add_item(text, icon, selectable)
