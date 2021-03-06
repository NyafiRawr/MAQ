
if global.gameState == ESong.prepare {
	var readyCount = 0;
	with (o_player) {
		if loading == 1
			readyCount++;
	}
	
	if o_player_host.loading == 1 
		readyCount++;
	
	var players = instance_number(o_player)+1;
	
	var col = players == readyCount ? c_green : c_white;
	color_mf0 col color_mf1;
	draw_text(480, 53, "Готовы\n" + string(readyCount) +"/"+ string(players));
}

color_mf0 c_white color_mf1;
var ctrl = o_control;
if (ctrl.countdown > 0) {
    ctrl.countdown -= delta_time / 1000000;
    color_mf0  c_red color_mf1;
    draw_text(480, 53, ceil(ctrl.countdown));
    
    draw_text(480, 515, "Пропустить?\n" + string(ctrl.skipPlayers)+ "/" +string(instance_number(o_player)));
    	
	if !surface_exists(timerSurf)
		timerSurf = surface_create(80, 80);
	if !shaderCompiled {
		color_mf0 c_white color_mf1;
		surface_set_target(timerSurf);
		draw_clear_alpha(c_black, 0);
		
		var _xx = 40;
		var _yy = 40;
		
		draw_circle(_xx, _yy, 32, false);
		gpu_set_blendmode(bm_subtract);
		draw_circle(_xx, _yy, 30, false);
		gpu_set_blendmode(bm_normal);
		
		draw_primitive_begin(pr_trianglefan);
		draw_vertex(_xx, _yy);
		var angle = 360 * (ctrl.countdown / ctrl.roundTime);
		for(var a = 0; a < angle; a += 2)
			draw_vertex(_xx+1 + lengthdir_x(28, a + 90), _yy+1 + lengthdir_y(28, a + 90));
		draw_primitive_end();
		gpu_set_blendmode(bm_subtract);
		draw_circle(_xx, _yy, 22, false);
		gpu_set_blendmode(bm_normal);
		surface_reset_target();
	
		draw_surface(timerSurf, 480 - 40, 10);
	} else {
		shader_set(sh_timer);
		shader_set_uniform_f(_timeMax, ctrl.roundTime);
		shader_set_uniform_f(_timeCur, ctrl.roundTime - ctrl.countdown);
		draw_surface(timerSurf, 480 - 40, 10);
		shader_reset();
	}
	
    if global.server != -1 {
	    if (ctrl.countdown <= 0) {
	        with(o_host_answer){
	        	script_execute(lambda_show_answer);
	        }
	        
	        instance_deactivate_object(o_host_hint);
	        instance_deactivate_object(o_host_answer);
	        instance_activate_object(o_host_next);
	    }
    }
}