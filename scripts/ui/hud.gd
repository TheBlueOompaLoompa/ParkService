extends CanvasLayer

@onready var tilemap = $Window/TileMapLayer

func make_mini(biome_image: Image):
    var tilemap = $Window/TileMapLayer
    var tilesource = tilemap.tile_set.get_source(0)

    var tiles_map: Dictionary = {}

    for tile in tilesource.get_tiles_count():
        var pos = tilesource.get_tile_id(tile)
        tiles_map[tilesource.get_tile_data(pos, 0).get_custom_data("biome_id")] = pos

    for x in biome_image.get_width():
        for y in biome_image.get_height():
            var pixel = biome_image.get_pixel(x, y).r
            tilemap.set_cell(Vector2i(x, y), 0, tiles_map[int(round(pixel))])

func player_pos(pos: Vector3):
    var mini_pos = pos / 10.0 * float(tilemap.tile_set.tile_size.x)
    tilemap.position = -Vector2(mini_pos.x, mini_pos.z)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
