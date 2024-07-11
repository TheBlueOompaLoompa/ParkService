extends Node3D

@onready var biome_gen = $BiomeGen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    biome_gen.gen_biomes(10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
