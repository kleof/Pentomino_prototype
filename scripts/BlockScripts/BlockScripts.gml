// hook pattern lesson courtesy of Jon Peterson
function FlashEffect(_owner, _color=c_white, _spd=.1) constructor {
	owner = _owner;
	color = _color;
	spd = _spd;
	alpha = 0;
	
	static start = function() {
		alpha = .9;
	}
	
	static draw = function() {
		if (alpha > 0) {
			gpu_set_fog(true,color,0,0);
			with(owner) draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, other.alpha);
			gpu_set_fog(false,0,0,0);
			alpha -= spd;
		}
    }
}

function FrameEffect(_owner, _sprite, _spd=.1) constructor {
	owner = _owner;
	sprite = _sprite;
	spd = _spd;
	frame = 0;
	
	static draw = function() {
		with(owner) draw_sprite_ext(other.sprite, other.frame, x, y, xscale, yscale, image_angle, c_white, 1);
		frame += spd;
		frame %= sprite_get_number(sprite);
	}
}

function OutlineEffect(_owner, _radius, _color1, _color2=undefined) constructor {
	owner = _owner;
	radius = _radius;
	color1 = _color1;
	color2 = _color2;
	fx = fx_create("_filter_outline");
	TPFunc(self, "update", function(v,t)
    {
		fx_set_parameter(t.fx, "g_OutlineColour", color_to_array(t.color1));
    });
	tween = TweenCreate(self, "Linear", "patrol", true, 0, .5, TPCol("color1"), color1, color2, "update", 0, 1);
	
	static start = function() {
		fx_set_single_layer(fx, true);
		fx_set_parameter(fx, "g_OutlineRadius", radius);
		fx_set_parameter(fx, "g_OutlineColour", color_to_array(color1));
		layer_set_fx(owner.layer, fx);
		if (color2 != undefined) TweenPlay(tween);
	}
	
	static stop = function() {
		if (color2 != undefined) TweenStop(tween);
		layer_clear_fx(owner.layer);	
	}
}
