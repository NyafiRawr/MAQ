
gpu_set_texfilter(1);
alpha = 1;
if  y > o_scroll_player.bbox_bottom{
	alpha = 1 - (y - o_scroll_player.bbox_bottom)/ 10;
	draw_set_alpha(alpha);
}

if  y < o_scroll_player.bbox_top{
	alpha = 1 - (o_scroll_player.bbox_top - y) / 10;
	draw_set_alpha(alpha);
}


if (avatar != -1) {
    draw_sprite_ext(avatar, 0, x, y, 32 / sprite_get_width(avatar), 32 / sprite_get_height(avatar), 0, c_white, 1);
} else {
    draw_sprite(s_noavatar, 0, x, y);
}
// Прогресс загрузки песни игроком
if (loading < 1) { draw_set_color(c_green);} else { draw_set_color(c_lime); }
draw_rectangle(x + 168, y, x + 178, y + 29, true);
draw_rectangle(x + 168, y + 29 - 29 * loading, x + 178, y + 29 , false);

draw_set_halign(fa_left);
// Ник и очки
draw_set_color(c_white);
draw_text(x + 38, y + 7, nickname);
draw_text(x + 38, y + 24, "Баллы: "+string(points));
// Ответ игрока - под игроком
draw_text(x + 10, y + 43, answer);
// Статус связи
draw_set_color(c_green);
draw_text(x + 185, y + 15, ping);
draw_set_halign(fa_center);

if alpha != 1
	draw_set_alpha(1);	

gpu_set_texfilter(0);