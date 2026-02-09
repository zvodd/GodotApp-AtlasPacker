class_name Artboard
extends Control

var grid_size = Vector2(32, 32)
var image_tiles = {}

func _draw():
	draw_grid()
	for uid in image_tiles:
		var image_tile = image_tiles[uid]
		var texture = image_tile.get_texture()
		if texture:
			var draw_pos = image_tile.position - texture.get_size() * image_tile.scale / 2
			draw_texture(texture, draw_pos, image_tile.scale)

func draw_grid():
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y

	for i in range(1, int(width / grid_size.x)):
		draw_line(Vector2(i * grid_size.x, 0), Vector2(i * grid_size.x, height), Color.GREEN_YELLOW)

	for i in range(1, int(height / grid_size.y)):
		draw_line(Vector2(0, i * grid_size.y), Vector2(width, i * grid_size.y), Color.GREEN_YELLOW)

func _can_drop_data(at_position, data):
	return  data.type == "image_tile"

func _drop_data(at_position, data):
	if data.type == "image_tile":
		var image_tile = data.image_tile
		image_tile.position = at_position
		if not image_tiles.has(image_tile.uid):
			add_image_tile(image_tile)
		update()

func add_image_tile(image_tile):
	image_tiles[image_tile.uid] = image_tile
	update()

func _get_drag_data(p_pos):
	for uid in image_tiles:
		var image_tile = image_tiles[uid]
		var texture = image_tile.get_texture()
		if texture:
			var rect = Rect2(image_tile.position - texture.get_size() * image_tile.scale / 2, texture.get_size() * image_tile.scale)
			if rect.has_point(p_pos):
				var data = {}
				data.type = "image_tile"
				data.image_tile = image_tile

				var preview = TextureRect.new()
				preview.texture = texture
				preview.size = rect.size
				set_drag_preview(preview)

				image_tiles.erase(uid)
				update()
				return data
	return null

func update():pass
#func set_drag_preview(_a):pass
