extends Node

export(int) var map_wide = 80
export(int) var map_hight =50
export(String) var world_seed= "Godotballs"
export(int) var noise_oct= 3
export(int) var noise_per = 3
export(float) var noise_pers = 0.7
export(float) var noise_l= 0.4
export(float) var noise_thresh = 0.5
export(bool) var redraw setget redraw

var tile_map: TileMap
var simplex_noise : OpenSimplexNoise = OpenSimplexNoise.new()

func _ready()-> void:
	self.tile_map = get_parent() as TileMap
	clear()
	generated()
	
func redraw(value = null) -> void:
	if self.tile_map == null:
		return
	clear()
	generated()
	
func clear()-> void:
	self.tile_map.clear()
	

func generated()-> void:
	self.simplex_noise.seed = self.world_seed.hash()
	self.simplex_noise.octaves = self.noise_oct
	self.simplex_noise.period = self.noise_per
	self.simplex_noise.persistence = self.noise_pers
	self.simplex_noise.lacunarity = self.noise_l
	
	for x in range(-self.map_wide /2, self.map_wide/2):
		for y in range(-self.map_hight / 2,self.map_hight / 2):
			if self.simplex_noise.get_noise_2d(x,y) < self.noise_thresh:
				self._set_autotile(x,y)
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

