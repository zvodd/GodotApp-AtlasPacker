class_name ImageTile
extends Resource

var file_name : String
var position : Vector2i
var scale : Vector2
var crop : Rect2i
var texture : Texture2D
var uid : String

func get_texture():
	if texture:
		return texture
	if file_name:
		texture = load(file_name)
		return texture
	return null
