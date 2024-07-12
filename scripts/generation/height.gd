extends Node
class_name HeightMap

@export var noise: FastNoiseLite

func gen_height(size: int):
    var texture = NoiseTexture2D.new()
    texture.width = size
    texture.height = size
    noise.seed = randi()
    texture.noise = noise

    await texture.changed
    return texture.get_image()
