extends Node
class_name BiomeGen

@export var biomes: Array[Biome]
var height_image: Image

func gen_biomes(size: int, p_height_image: Image):
    height_image = p_height_image
    var out = WaveFunction.gen_texture(size, biome_rule)
    height_image = null
    return out

func biome_rule(px: int, py: int, image: Image, size: int):
    var biome_list = list_biomes()
    var possible = biome_list

    # Only allow possible biome neighbors
    for x in range(px + -1, px + 2):
        for y in range(py + -1, py + 2):
            if (x == px and y == py) or x < 0 or y < 0 or x >= size or y >= size:
                continue
            else:
                var pixel = image.get_pixel(x, y).r
                for biome in biome_list:
                    var biome_idx = fidx(biome)
                    assert(biome_idx > -1, "Biome doesn't exist.")
                    if pixel == biome_idx:
                        possible = reduce_neighbors(possible, biome)

    assert(possible.size() > 0, "NOTHING IS POSSIBLE 1 :((((")

    # Only allow in height range
    var save_possible = []
    save_possible.append_array(possible)
    for biome_name in possible:
        var biome = find_biome(biome_name)
        if float(biome.min_height)/100.0 >= height_image.get_pixel(px, py).r or float(biome.max_height)/100.0 <= height_image.get_pixel(px, py).r:
            possible.erase(biome_name)

    if possible.size() == 0:
        possible = save_possible

    assert(possible.size() > 0, "NOTHING IS POSSIBLE 2 :((((")

    # Collapse with probability pot
    var pot = 0
    for left in possible:
        pot += find_biome(left).probability

    var pick = randi() % pot

    var total = 0

    for biome in possible:
        for x in find_biome(biome).probability:
            if total == pick:
                return fidx(biome)

            total += 1

    # Return nothing if it somehow failed
    return -1

func find_biome(biome_name: String) -> Biome:
    return GD_.find(biomes, ["name", biome_name])

func list_biomes():
    return GD_.map(biomes, func(biome, _k): return String(biome.name))

func reduce_neighbors(possible, biome_name: String):
    var neighbors = find_biome(biome_name).neighbors
    neighbors.append(biome_name)
    return GD_.intersection(possible, neighbors)
#
## Find biome idx
func fidx(p_name: String):
    return GD_.find_index(biomes, ["name", p_name])
