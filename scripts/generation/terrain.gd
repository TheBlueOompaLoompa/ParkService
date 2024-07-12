extends Node3D
class_name Terrain

@onready var biome_gen = $BiomeGen

@export var biome_image: Image

## Fires after terrain is loaded or generated
signal terrain_finished(terrain: Terrain)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    biome_image = biome_gen.gen_biomes(50)
    print("Generated biomes")
    
    terrain_finished.emit(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
