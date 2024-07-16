var _new_xgrid = floor(mouse_x/grid_size);
var _new_ygrid = floor(mouse_y/grid_size);

if (_new_xgrid == xgrid && _new_ygrid == ygrid) exit;

xgrid = _new_xgrid;
ygrid = _new_ygrid;
//TweenFire(id, "oSine", 0, true, 0, .05, "x>", (xgrid + .5) * grid_size, "y>", (ygrid + .5) * grid_size);
x = (xgrid + .5) * grid_size;
y = (ygrid + .5) * grid_size;
