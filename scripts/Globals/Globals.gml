#macro GRID 30
global.xgrid = floor(mouse_x/GRID);
global.ygrid = floor(mouse_y/GRID);
global.grid_update = false; // grid coordinates changed -> look o_clickable_depth_manager
