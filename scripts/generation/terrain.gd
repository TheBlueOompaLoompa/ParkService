extends Node3D
class_name Terrain

@onready var biome_gen = $BiomeGen
@onready var height_map = $HeightMap

@export var height_image: Image
@export var biome_image: Image

## Fires after terrain is loaded or generated
signal terrain_finished(terrain: Terrain)

const TERRAIN_SIZE = 25 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    height_image = await height_map.gen_height(TERRAIN_SIZE)
    biome_image = biome_gen.gen_biomes(TERRAIN_SIZE, height_image)
    print("Generated biomes")
    
    terrain_finished.emit(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
