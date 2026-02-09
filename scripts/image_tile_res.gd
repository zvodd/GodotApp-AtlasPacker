class_name ImageTile
extends Resource

var file_name : String
var position : Vector2i
var scale : Vector2
var crop : Rect2i
var texture : Texture2D
var image : Image
var uid : String

func get_image():
	if image:
		return image
	if file_name:
		image = Image.new()
		image.load(file_name)
		return image
	return null

func get_texture():
	if texture:
		return texture
	if file_name:
		self.get_image()
		texture = ImageTexture.create_from_image(image)
		return texture
	return null
