extends Node3D

func _on_terrain_finished(terrain: Terrain):
    $HUD.make_mini(terrain.biome_image)    


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
