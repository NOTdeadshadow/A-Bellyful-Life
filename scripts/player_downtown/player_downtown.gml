function d_player_downtown(){
	dialogue_init();
	dialogue_create(
	"1",
	"Jog around downtown (25 mins)",
	true,
	function(){
		background_set(asset_get_index("sprDowntown"+str(choose(1,2,3,4))))
		player_jog_energy(25);
		global.scene_script = player_downtown;
		scene_start();
	}
	)
	
	dialogue_create(
	"2",
	"Go to public fountain (5 mins)",
	true,
	function(){
		room_goto(rmFountain);
	}
	)
	dialogue_start(true);
}

function player_downtown(){
	global.scene_name = "Park";
	global.scene_inflate_rate = 0;
	global.scene_interface = false;
	scene_add_actors(Player, noone, noone);
	background_set(asset_get_index("sprDowntown"+str(choose(1,2,3,4))))
	
	var msg_finish_jog = strlan(
				EN, "You began jogging through downtown. You can feel the refreshing air lifting your mood.",
				CN, "你开始在公园中慢跑。清凉的空气改善了你的心情。",
				JP, "公園をジョギングし始めた。爽やかな空気が気分を良くしてくれます。",
				RUS, "Ты начала бегать по парку. Ты можешь почувствовать, как освежающий воздух поднимает твое настроение."
			);
			
	ctb_list(player_jog_finish, noone , 
			msg_finish_jog
		);
}