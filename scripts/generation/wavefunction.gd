class_name WaveFunction

static func gen_texture(size: int, rule: Callable) -> Image:
	var image := Image.create_empty(size, size, false, Image.Format.FORMAT_RF)
	
	for x in size:
		for y in size:
			image.set_pixel(x, y, Color(rule.call(x, y, image, randf(), size), 0, 0))

	return image
