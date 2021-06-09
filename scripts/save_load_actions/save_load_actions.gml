function save_action(){
	with (SaveSticker) {
		if (image_alpha == 1){
			global.save_index = index;	
		}
	}
	
	custom_goto(rmBedroom);
}

function load_action(){
	audio_stop_sound(bgm_intro);
	audio_sound_gain(bgmA, 1, 60);
	with (SaveSticker) {
		if (image_alpha == 1){
			global.load_index = index;	
		}
	}
	custom_goto(rmBedroom);
}

function delete_action(){
	with (SaveSticker) {
		if (image_alpha == 1){
			global.delete_index = index;	
		}
	}
	
	ds_map_delete(global.metadata, str(global.delete_index));
	file_delete(working_directory + "save" +str(global.delete_index) +".json");
	save_map_to_file(global.metadata, "metadata.json");
}