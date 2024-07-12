extends StaticBody3D
class_name TerrainGen

@export var chunk_size = 10
@export var height_multiplier = 10.0

func gen_mesh(size: int, height_image: Image):
    var mesh = ArrayMesh.new()
    var surface_array = []
    surface_array.resize(Mesh.ARRAY_MAX)

    var verts = PackedVector3Array()
    var uvs = PackedVector2Array()
    var normals = PackedVector3Array()
    var indices = PackedInt32Array()

    var new_size = size*chunk_size

    for y in new_size:
        for x in new_size:
            verts.append(Vector3(x, height_image.get_pixel(floori(x/float(chunk_size)), floori(y/float(chunk_size))).r*height_multiplier, y))
            uvs.append(Vector2(float(x)/float(size), float(y)/float(size)))
            normals.append(Vector3.UP)

    for y in new_size - 1:
        for x in new_size - 1:
            indices.push_back(y*new_size+x)
            indices.push_back(y*new_size+x+1)
            indices.push_back(y*new_size+new_size+x)

            indices.push_back(y*new_size+new_size+x)
            indices.push_back(y*new_size+x+1)
            indices.push_back(y*new_size+new_size+x+1)


    # TODO: CALCULATE NORMALS
    
    surface_array[Mesh.ARRAY_VERTEX] = verts
    surface_array[Mesh.ARRAY_TEX_UV] = uvs
    surface_array[Mesh.ARRAY_NORMAL] = normals
    surface_array[Mesh.ARRAY_INDEX] = indices

    mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)
    $CollisionShape3D.shape = mesh.create_trimesh_shape()
    $MeshInstance3D.mesh = mesh
