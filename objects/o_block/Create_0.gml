tween_type = "oElastic";
tween_dur = .5;
target_angle = image_angle;
active = true;
hover = false;
selected = false;

outline_fx = layer_get_fx("Outline");
c_hover = [1.,0.792,0.11,1];
c_selected = [0.176,1.,0.957,1];

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
	if (!global.grid_update) exit;
	x = (global.xgrid + .5) * GRID;
	y = (global.ygrid + .5) * GRID;
}

#endregion

init_state(idle_state);
