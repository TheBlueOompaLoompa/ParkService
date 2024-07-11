extends Node
class_name HeightMap

var biome_map: Image

func gen_height(size: int, biomes: Image):
    biome_map = biomes
    WaveFunction.gen_texture(size, height_rule)

func height_rule(px: int, py: int, image: Image, size: int):
    for x in range(px + -1, px + 2):
        for y in range(py + -1, py + 2):
            if (x == px and y == py) or x < 0 or y < 0 or x >= size or y >= size:
                continue
            else:
                var pixel = image.get_pixel(x, y).r
                var neighbor_biome = BiomeGen.get_biome_by_px(round(biome_map.get_pixel(x, y).r))[1]
