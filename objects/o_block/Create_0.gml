tween_type = "oElastic";
tween_dur = .5;
target_angle = image_angle;
active = true;
hover = false; // set by o_clickable_manager
selected = false;
xscale = 1; yscale = 1; // for scale effects, so it does not interfere with collision mask
flash = new FlashEffect(id, c_white, .08);
frame = new FrameEffect(id, s_block_frame, .1);
outline = new OutlineEffect(id, 2, #EC6353, #89FFF9);

//c_hover_1 = #FFFF7F;
//c_hover_2 = #FFFF7F//#89FFF9;
//TweenFire(self, "ioSine", "patrol", true, 0, 1, TPCol("c_hover_1>"), c_hover_2);
//c_selected = color_to_array(#9CFF1B);//color_to_array(#EC6353);

#region IDLE STATE

idle_state = new State();
idle_state.start = function() {
	show_debug_message("IDLE");
}

idle_state.run = function() {
	if hover change_state(hover_state);
}

#endregion

#region HOVER OVER STATE

hover_state = new State();
hover_state.start = function() {
	show_debug_message("HOVER");
	if (last_state == idle_state) {
		flash.start();
		TweenFire(id, ac_pulse, 0, true, 0, .3, "xscale", sign(xscale), 1.4*sign(xscale),
												"yscale", sign(yscale), 1.4*sign(yscale));
	}
}

hover_state.run = function() {
	if (not hover) change_state(idle_state);
	//fx_set_parameter(outline_fx, "g_OutlineColour", color_to_array(c_hover_1));
	if mouse_check_button_pressed(mb_left) change_state(selected_state); // add move to mouse animation
}

#endregion

#region SELECTED STATE

selected_state = new State();
selected_state.start = function() {
	selected = true;
	layer = layer_get_id("selected");
	outline.start();
	//fx_set_parameter(outline_fx, "g_OutlineColour", c_selected);
	TweenFinish({target: id});
	show_debug_message("SELECTED");
	var _x = (global.xgrid + .5) * GRID;
	var _y = (global.ygrid + .5) * GRID;
	TweenFire(id, "oExpo", 0, true, 0, .1, "x>", _x, "y>", _y);
	TweenFire(id, "oElastic", 0, true, 0, .6, "xscale", .8 * sign(xscale), 1.1*sign(xscale),
											  "yscale", .8 * sign(yscale), 1.1*sign(yscale));
}

selected_state.run = function() {
	if mouse_check_button_pressed(mb_left) change_state(hover_state);
	if mouse_wheel_up() {
		target_angle += 90;
		TweenFire(id, tween_type, 0, true, 0, tween_dur, "image_angle>", target_angle);
	}
	if mouse_wheel_down() {
		target_angle -= 90;
		TweenFire(id, tween_type, 0, true, 0, tween_dur, "image_angle>", target_angle);
	}
	if mouse_check_button_pressed(mb_right) {
		TweenFinish({target: id});
		xscale *= -1;
		image_xscale = sign(image_xscale) * -1;
		TweenFire(id, ac_pulse, 0, true, 0, .3, "xscale>",  1.6*sign(xscale),
												"yscale>",  1.6*sign(yscale));
		//xscale = 1.1 * -sign(xscale);
		//yscale = 1.1;
		//TweenFire(id, "oElastic", 0, true, 0, .7, "xscale>", sign(xscale),
		//										  "yscale>", sign(yscale));	
	}
	
	if (!global.grid_update) exit;
	var _x = (global.xgrid + .5) * GRID;
	var _y = (global.ygrid + .5) * GRID;
	TweenFire(id, "oExpo", 0, true, 0, .2, "x>", _x, "y>", _y);
}

selected_state.stop = function() {
	selected = false;
	outline.stop();
	layer = layer_get_id("Instances");
	TweenFinish({target: id});
	xscale = sign(xscale);
	yscale = sign(yscale);
}

#endregion

init_state(idle_state);
