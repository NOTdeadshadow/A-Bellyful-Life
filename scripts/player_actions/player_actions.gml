function player_throw_up(){
	sndVomit = get_random_asset("sndVomit", 1, 5);
	audio_play_sound(sndVomit, 0, 0);
	
	//Player.stomach_content -= min(Player.stomach_capacity/5,Player.stomach_content);
	Player.stomach_air *= 0.5;
	Player.stomach_water *= 0.5;
	Player.stomach_food *= 0.5;
	Player.stomach_pressure *=0.5;
	
	//if (Player.stomach_content < 0)
	//	Player.stomach_content = 0;
}

function player_expel(){
	audio_play_sound(sndFlush, 0, 0);
	
	Player.bowels_air *= 0.5;
	Player.bowels_water *= 0.5;
	Player.bowels_food *= 0.5;
	Player.bowels_pressure *=0.5;
	//if (Player.stomach_content < 0)
	//	Player.stomach_content = 0;
}