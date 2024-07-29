// Check if grid coordinates changed
var _new_xgrid = floor(mouse_x/GRID);
var _new_ygrid = floor(mouse_y/GRID);

if (_new_xgrid != global.xgrid || _new_ygrid != global.ygrid) {
	global.grid_update = true;
	global.xgrid = _new_xgrid;
	global.ygrid = _new_ygrid;
} else global.grid_update = false;

// Look for any clickable objects under cursor
var _under_cursor = [];
with (o_clickable) {
	if 	(position_meeting(mouse_x, mouse_y, id)) {
		array_push(_under_cursor, id);
	}
}
// NOTHING FOUND
if (array_length(_under_cursor) == 0) {
	if (current_hover != noone) {
		current_hover.hover = false;
		current_hover = noone;
	}
	window_set_cursor(cr_default);
	exit;
}

// MOUSE IS OVER OBJECT(S) - Find one with lowest depth
array_sort(_under_cursor, function(_a, _b) { return _b.depth - _a.depth }); // ?check if correct
window_set_cursor(cr_handpoint);

if (_under_cursor[0] != current_hover) {
	if (current_hover != noone) current_hover.hover = false;
	current_hover = _under_cursor[0];
	current_hover.hover = true;
}