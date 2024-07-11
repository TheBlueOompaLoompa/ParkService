class_name BiomeGen

static var Biomes = {
    "tallgrass":    { "probability": 10, "neighbors": ["tallgrass", "grass"] },
    "grass":        { "probability": 8, "neighbors": ["grass", "tallgrass", "beach"] },
    "beach":        { "probability": 4, "neighbors": ["beach", "grass", "lake"] },
    "lake":         { "probability": 8, "neighbors": ["beach", "lake"] },
}

static func gen_biomes(size: int):
    WaveFunction.gen_texture(size, biome_rule)

static func biome_rule(px: int, py: int, image: Image, entropy: float, size: int):
    var possible := Biomes.keys()

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

    # Collapse with probability pot
    var pot = 0
    for left in possible:
        pot += Biomes[left]["probability"]

    var pick = randi() % pot

    var total = 0

    for biome in Biomes.keys():
        for x in Biomes[biome]["probability"]:
            total += x
            if total == pick:
                print(biome)
                return Biomes.keys().find(biome)

    # TODO: Return real value
    return 0

static func reduce_neighbors(possible, biome_name: String):
    return GD_.intersection(possible, Biomes[biome_name]["neighbors"])

# Find biome idx
static func fidx(name: String):
    if Biomes.has(name):
        return Biomes.keys().find(name)
    return -1
