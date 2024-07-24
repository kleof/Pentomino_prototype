//if (hover) {
//	var _border = 5*2;
//	var _xscale = (sprite_width + _border)/sprite_width;
//	var _yscale = (sprite_height + _border)/sprite_height;

//	var _y = (sprite_yoffset - sprite_height/2) * (_yscale - 1);
//	var _x = (sprite_xoffset - sprite_width/2) * (_xscale - 1);

//	gpu_set_fog(true,#ED008C,0,0);
//	draw_sprite_ext(sprite_index, image_index, x+_x, y+_y, _xscale*sign(image_xscale), _yscale*sign(image_yscale), image_angle, c_white, 1);
//	gpu_set_fog(false,c_white,0,0);
//}

draw_self();
