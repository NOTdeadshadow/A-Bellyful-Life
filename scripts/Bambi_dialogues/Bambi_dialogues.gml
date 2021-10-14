function Bambi_dialogues(){
	dialogue_init()
	dialogue_create(
			    "1",
			    "Not implemented",
			    false,
				"Not implemented"
		)
	
	eating_out_ask(Bambi);
	
	dialogue_start(true);
}

function Bambi_intro_scene(){
	global.scene_name = "Bambi Intro";
	global.scene_inflate_rate = 0;
	global.scene_interface = false;
	global.scene_exit = false;
	global.show_follower = false;
	//scene_add_actors(Player, noone, noone);
	background_set(sprBambi_Intro1);
	time_forward_minutes(30);
	exelan("msg_Bambi_intro");
}

function Bambi_help_scene(){
	global.scene_name = "FeedCows";
	global.scene_inflate_rate = 0;
	global.scene_interface = false;
	global.scene_exit = false;
	global.show_follower = false;
	scene_add_actors(Player, noone, noone);
	scene_add_actors(Bambi, noone, noone);
	exelan("msg_Bambi_feedcows");
	global.scene_script = Bambi_poultry_scene;
}

function Bambi_poultry_scene(){
	global.scene_name = "Poultry";
	global.scene_inflate_rate = 0;
	global.scene_interface = false;
	global.scene_exit = false;
	global.show_follower = false;
	scene_add_actors(Player, noone, noone);
	scene_add_actors(Bambi, noone, noone);
	exelan("msg_Bambi_poultry");
	Bambi.likability += 5;
	time_forward_minutes(60);
}