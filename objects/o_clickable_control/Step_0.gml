var _under_cursor = [];

with (o_clickable) {
	if 	(position_meeting(mouse_x, mouse_y, id)) {
		array_push(_under_cursor, id);
	}
}
// NOTHING TO CLICK
if (array_length(_under_cursor) == 0) exit;

// SOMETHING TO CLICK
array_sort(_under_cursor, function(_a, _b) { return _b.depth - _a.depth }); //check if correct
show_debug_message(_under_cursor[0]);