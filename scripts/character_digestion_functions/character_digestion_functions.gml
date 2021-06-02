function ingest(target,entrance, type, amount){
	var content, capacity, side, vname;
	switch(entrance){
		case ORAL:
			side = "stomach";
		break;
		case ANAL:
			side = "bowels";
		break;
	}
	
	content = variable_instance_get(target, side + "_content");
	capacity = variable_instance_get(target, side + "_capacity");
	
	var modifier = character_capacity_modifier(target);
	if (content >= capacity*modifier)
		return false;
	
	switch(type){
		case WATER:
			vname = "water";
		break;
		case AIR:
			vname = "air";
		break;
		case FOOD:
			vname = "food";
		break;
	}
	vname = side  + "_"+vname;
	variable_instance_set(target, vname, variable_instance_get(target, vname)+amount);
	
	//calculate pressure increase
	var pressure_inc = (amount/capacity)*1.6*100;//double percentage of capacity
	vname = side + "_" + "pressure";
	variable_instance_set(target, vname, variable_instance_get(target, vname)+pressure_inc);
	
	change_mood(target, 0.1, true);
	if (content + amount > capacity*modifier)
		return 2;
	return 1;
		
}

function pressure_step(minutes){
	//lol TODO FIX
	for (var i=0; i < minutes; i++){
		if (stomach_pressure > (stomach_content/stomach_capacity)*75)
			stomach_pressure *= 0.97;	
		if (bowels_pressure > (bowels_content/bowels_capacity)*75)
			bowels_pressure *= 0.97;
	}
}

function digest_step(minutes){
	if (jittery > 0)
		jittery -= min(minutes/12, jittery);
	if (alcohol > 0)
		alcohol -= min(minutes/12, alcohol);
	if (high > 0)
		high -= min(minutes/12, high);
		
	var gas = statuses_count[? "pill_gas"];
	if (gas > 0){
		stomach_air += minutes * 6;
		bowels_air += minutes * 6;
	}
	var noise = statuses_count[? "pill_noise"];
	if (noise > 0){
		if (random(1) < (noise * minutes)/10){
			play_stomach_sound()	
		}//else
		//	show_message(string(random(1)) + " < " +string(noise * minutes))
	}
	
	var lax = statuses_count[? "pill_laxative"];
	if (lax > 0){
		if (random(1) < (lax * minutes)/30){
			ds_list_clear(statuses[? "pill_laxative"]);
			audio_play_sound(sndFlush, 0,0);
			change_mood(id, -20, 1);
			change_energy(id, -30, 1);
			ctb_list(noone, noone, "Unable to hold it in any longer, you ran to the nearest bathroom.");
			time_forward_minutes(15);
		}else{
			play_stomach_sound();
			if (!instance_exists(obj_textbox))
				ctb_list(noone, noone, "Your stomach aches terribly.");
		}
	}
	
	var modifier = 1;
	
	var pdigest = statuses_count[? "pill_digest"],
		pdiet = statuses_count[? "pill_diet"];
		
	modifier += power(1.5, pdigest) + power(0.5, pdiet);
	minutes *= modifier;
	
	daily_minutes += minutes;
	
	if (hunger == 0){
			change_energy(id, minutes/30, true);
	}else if (hunger == 1){
			
	}else if (hunger == 2){
			change_energy(id, -minutes/15, true);
	}
	
	if (stomach_content/stomach_capacity >= 0.9 && stomach_air > 30)
		do_burp();
	
	daily_stomach_content += (stomach_content/stomach_capacity)*minutes;
	amount =( minutes/1600)*stomach_capacity; //complete digestion in 480 minutes
	amount = min(amount, stomach_content);
	
		if(amount > 0){
			//calc weights
			w_water = stomach_water/stomach_content;
			w_air = stomach_air/stomach_content;
			w_food = stomach_food/stomach_content;
	
		    stomach_water -= amount*w_water;
			stomach_air -= amount*w_air;
		
			if (stomach_food > 0){
				var digested_cal = (undigested_calories* amount*w_food)/stomach_food;
				stomach_food -= amount*w_food;
		
				undigested_calories -= digested_cal;
				daily_calories += digested_cal;
			}
		}
	if (bowels_content/bowels_capacity >= 0.9 && bowels_air > 30)
		do_fart();
	daily_bowels_content += (bowels_content/bowels_capacity)*minutes;
		
	amount =( minutes/1600)*bowels_capacity;
	amount = min(amount, bowels_content);
	if(amount > 0){
		//calc weights
		w_water = bowels_water/bowels_content;
		w_air = bowels_air/bowels_content;
		w_food = bowels_food/bowels_content;
	
	    bowels_water -= amount*w_water;
		bowels_air -= amount*w_air;
		bowels_food -= amount*w_food;
	}

	
}

function character_capacity_modifier(target){
		var m = 1;
		if (target.alcohol >= 30){
			m += target.alcohol/100;
		}
		if (target.jittery >= 30){
			m += target.jittery/200;
		}
		
		return m;
}