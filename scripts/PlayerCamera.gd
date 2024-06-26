extends Camera2D

@export var tilemap: TileMap

func _ready():
	var mapRect = tilemap.get_used_rect()	
	var tileSize = tilemap.tile_set.tile_size
	var worldSizeInPixels = mapRect.size * tileSize
	
	print(worldSizeInPixels)
	
	limit_right = worldSizeInPixels.x
	limit_bottom = worldSizeInPixels.y
	limit_left = 0
	limit_top = 0
	
