value = Player.statuses_count[? "pill_gas"];
if (value <= 0){
	exit;
}
draw_self();
draw_set_color(c_black);
draw_text(x,y, string(value));