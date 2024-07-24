tween_type = "oElastic";
tween_dur = .5;
target_angle = image_angle;
active = true;
hover = false;
selected = false;

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
	layer = layer_get_id("Selected");
	
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
}

selected_state.run = function() {
	if (!global.grid_update) exit;
	x = (global.xgrid + .5) * GRID;
	y = (global.ygrid + .5) * GRID;
}

#endregion

init_state(idle_state);
