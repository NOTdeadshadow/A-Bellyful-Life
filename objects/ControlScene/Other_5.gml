sounds = global.scene_sound_action
if (sounds != noone){
	for (var i=0; i < ds_list_size(sounds); i ++){
		audio_stop_sound(sounds[| i]);
	}
}

if (watched_inflate && global.show_follower){
	global.watched_inflate = true;	
}

if (!global.scene_bgm && bgm != noone){
	audio_sound_gain(bgm, 1 , 30);	
}