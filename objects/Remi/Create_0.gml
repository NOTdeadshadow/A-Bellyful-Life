event_inherited();
script_location = Remi_location;
script_dialogue = Remi_dialogues;
//script_idle = alice_idle;
//script_observe = alice_observe;

sprite_expression = sprRemiExpressions_0;
interested = false;
//has_number = true;

eating_out_init(rmFataurant, list_create(IBeer, IHotdog, ISoda, IHotdog));

arrive_msg = "I'm here to keep an eye on you.";

catching = noone;
catch_success = false;
catch_dialogue = false;