image_xscale = 1.1 * -sign(image_xscale);
image_yscale = 1.1;
TweenFire(id, "oElastic", 0, true, 0, .7, "image_xscale>", sign(image_xscale),
										  "image_yscale>", sign(image_yscale));