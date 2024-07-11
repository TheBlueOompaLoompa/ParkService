class_name WaveFunction

static func gen_texture(size: int, rule: Callable) -> Image:
    var image := Image.create_empty(size, size, false, Image.Format.FORMAT_RF)
    
    image.fill(Color(-1, 0, 0))

    for x in size:
        for y in size:
            var pixel_val = rule.call(x, y, image, size)
            assert(pixel_val > -1, "Negative wave function value")
            image.set_pixel(x, y, Color(pixel_val, 0, 0))

    return image
