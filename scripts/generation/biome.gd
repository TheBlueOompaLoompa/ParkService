class_name Biome
extends Resource

@export var name = "Unnamed"
@export var probability: int = 5
@export var neighbors: Array[String] = []

@export_group("Height")
## This value is divided by 10
@export var min_height: int = 0
## This value is divided by 10
@export var max_height: int = 10
## This is the amount the height can change from point to point on grid
@export var height_variation: float = 1.0
@export_range(0.0, 1.0) var slope_min: float = 0.0
@export_range(0.0, 1.0) var slope_max: float = 1.0
