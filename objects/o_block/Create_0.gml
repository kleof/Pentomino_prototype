tween_type = "oElastic";
tween_dur = .5;
target_angle = image_angle;
active = true;
hover = false;
selected = false;

outline_fx = layer_get_fx("Outline");
c_hover = color_to_array(#FFCA1C);
c_selected = color_to_array(#2CFFF4);

#region IDLE STATE

idle_state = new State();
idle_state.start = function() {
	show_debug_message("IDLE");
	layer = layer_get_id("Instances");
}

idle_state.run = function() {
	if hover change_state(hover_state);
}

#endregion

#region HOVER OVER STATE

hover_state = new State();
hover_state.start = function() {
	show_debug_message("HOVER");
	layer = layer_get_id("Outline");
	fx_set_parameter(outline_fx, "g_OutlineColour", c_hover);
}

hover_state.run = function() {
	if (not hover) change_state(idle_state);
	if mouse_check_button_pressed(mb_left) change_state(selected_state); // add move to mouse animation
}

#endregion

#region SELECTED STATE

selected_state = new State();
selected_state.start = function() {
	show_debug_message("SELECTED");
	var _x = (global.xgrid + .5) * GRID;
	var _y = (global.ygrid + .5) * GRID;
	TweenFire(id, "oExpo", 0, true, 0, .1, "x>", _x, "y>", _y);
	fx_set_parameter(outline_fx, "g_OutlineColour", c_selected);
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
		image_xscale = 1.1 * -sign(image_xscale);
		image_yscale = 1.1;
		TweenFire(id, "oElastic", 0, true, 0, .7, "image_xscale>", sign(image_xscale),
												  "image_yscale>", sign(image_yscale));	
	}
	
	if (!global.grid_update) exit;
	x = (global.xgrid + .5) * GRID;
	y = (global.ygrid + .5) * GRID;
	//TweenFire(id, "oExpo", 0, true, 0, .1, "x>", tx, "y>", ty);
}

#endregion

init_state(idle_state);
