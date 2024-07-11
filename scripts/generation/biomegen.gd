extends Node
class_name BiomeGen

@export var biomes: Array[Biome]

#static var Biomes = {
#    "tallgrass":    { "probability": 10, "height_range": [15, 20], "height_variation": 1, "neighbors": ["tallgrass", "grass"] },
#    "grass":        { "probability": 8, "height_range": [15, 20], "height_variation": 1, "neighbors": ["grass", "tallgrass", "beach"] },
#    "beach":        { "probability": 4, "height_range": [10, 15], "height_variation": 1, "neighbors": ["beach", "grass", "lake"] },
#    "lake":         { "probability": 8, "height_range": [0, 10], "height_variation": 1, "neighbors": ["beach", "lake"] },
#}

func gen_biomes(size: int):
    WaveFunction.gen_texture(size, biome_rule)

# Returns an array [0] = name, [1] = Biome info
#static func get_biome_by_px(pixel: int):
#    var key = Biomes.keys().find(pixel)
#    return [key, Biomes[key]]

func list_biomes():
    return GD_.map(biomes, func(biome, _k): return String(biome.name))

func biome_rule(px: int, py: int, image: Image, size: int):
    var possible = list_biomes()


    # Only allow possible biome neighbors
    for x in range(px + -1, px + 2):
        for y in range(py + -1, py + 2):
            if (x == px and y == py) or x < 0 or y < 0 or x >= size or y >= size:
                continue
            else:
                var pixel = image.get_pixel(x, y).r
                for biome in Biomes.keys():
                    if pixel == fidx(biome):
                        possible = reduce_neighbors(possible, biome)

    print(possible)
    return 0
#    # Collapse with probability pot
#    var pot = 0
#    for left in possible:
#        pot += Biomes[left]["probability"]
#
#    var pick = randi() % pot
#
#    var total = 0
#
#    for biome in possible:
#        for x in Biomes[biome]["probability"]:
#            if total == pick:
#                return Biomes.keys().find(biome)
#
#            total += 1
#
#    # Return nothing if it somehow failed
#    return -1
#
#func reduce_neighbors(possible, biome_name: String):
#    return GD_.intersection(possible, Biomes[biome_name]["neighbors"])
#
## Find biome idx
#func fidx(name: String):
#    if Biomes.has(name):
#        return Biomes.keys().find(name)
#    return -1
