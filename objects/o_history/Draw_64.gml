
if !surface_exists(historySurf)
	historySurf = surface_create(sprite_width, sprite_height);

draw_self();
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(x + 20, y - 20, string(o_control.roundCurrent+1) +" / "+ string(o_control.roundTotal+1));

surface_set_target(historySurf);
draw_clear_alpha(c_black, 0);

var str;
var yy = 10 + scrolled;
for(var a = 0; a < array_height_2d(game_arr); a++){
	str = string(a+1)+". "+ game_arr[@ a, EData.name];
	
	if a == o_control.roundCurrent
		str = "> " + str;

	strHe = string_height_ext(str, 17, sprite_width - 10);
	draw_text_ext(5, yy, str, 17, sprite_width - 10);
	yy += strHe;
}
surface_reset_target();


if shaderCompiled {
	shader_set(sh_history);
	draw_surface(historySurf, x, y);
	shader_reset();
} else {
	draw_surface(historySurf, x, y);
}

draw_set_valign(fa_middle);
draw_set_halign(fa_middle);

