// Check which clickable object is on top in case of overlap
var _under_cursor = [];
with (o_clickable) {
	if 	(position_meeting(mouse_x, mouse_y, id)) {
		array_push(_under_cursor, id);
	}
}
// NOTHING FOUND
if (array_length(_under_cursor) == 0) exit;

// MOUSE IS OVER OBJECT(S)
array_sort(_under_cursor, function(_a, _b) { return _b.depth - _a.depth }); // ?check if correct

if (_under_cursor[0] != currently_hovered_over) {
	if (currently_hovered_over != noone) currently_hovered_over.hover = false;
	currently_hovered_over = _under_cursor[0];
	currently_hovered_over.hover = true;
}