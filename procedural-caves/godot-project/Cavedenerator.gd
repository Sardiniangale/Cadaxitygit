extends Node

export(String) var world_seed= "Godotballs"
export(int) var noise_oct= 3
export(int) var noise_per = 3
export(float) var noise_pers = 0.7
export(float) var noise_l= 0.4


var tile_map: TileMap
var simplex_noise : OpenSimplexNoise = OpenSimplexNoise.new()

func _ready()-> void:
	self.tile_map = get_parent() as TileMap
	clear()
	generated()
	
func clear()-> void:
	self.tile_map.clear()

func generated()-> void:
	self._set_autotile(0,0)
	self.tile_map.update_dirty_quadrants()
	
func _set_autotile(x: int, y:int)-> void:
	self.tile_map.set_cell(
		x,
		y,
		self.tile_map.get_tileset().get_tiles_ids()[0],
		false,
		false,
		false,
		self.tile_map.get_cell_autotile_coord(x,y)
		)
	self.tile_map.update_bitmask_area(Vector2(x,y))

