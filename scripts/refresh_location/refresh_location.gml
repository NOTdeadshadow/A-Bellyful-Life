function refresh_location() {
	if (ControlEnv.hours > 18 || ControlEnv.hours < 6)
	    set_night_bg();
	else
	    set_day_bg();
		
	//fix bug
	global.dialogue_char = Player;
	
	with (CharacterHolder) instance_destroy();
	
//	if (!is_location())
//		return;

	for (i = 0; i < instance_number(Character); i ++){
	    c = instance_find(Character, i);
	    if (c == Player.id)
	        continue;
		global.dialogue_char = c;
	    if (script_execute(c.script_location, c) == room){
	        create_character_holder(c);
			//if (keyboard_check(vk_delete))
				//	show_message(room_get_name(room));
		}else if (c.name == "Amber"){
			//(room_get_name(script_execute(c.script_location, c)));
		}
	}
	global.dialogue_char = noone;
	



}
