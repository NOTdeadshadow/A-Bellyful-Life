width = item.sprite_width + 10;    
height = item.sprite_height + 10;
image_xscale = width/100;
image_yscale = height/100;

if (!global.abilities[? "check"] && 
    (item.in_stomach || item.in_bowels)){
    visible = false;
}

if (dragging){
	drag_counter ++;
	if (drag_counter > 20){
		with(ItemCard) image_alpha = 0.5;
		var closest = instance_place(x,y,ItemCard);
		if (instance_exists(closest))
			closest.image_alpha = 1;
		image_alpha = 1;
	}
	
    x = mouse_x - width/2;
    y = mouse_y - height/2;
    
	//move out if in inventory
	if (item.script_use_on_item == noone && room == rmBackpack && point_distance(x,y,xstart, ystart) > 100){
		persistent = true;
		depth = -2;
		room_goto(global.last_room);
	}
    
}else{
		drag_counter = 0;
    if (!item.in_stomach && !item.in_bowels){
		if (persistent &&  point_distance(x,y,xstart, ystart) <= 100){
			persistent = false;
			room_goto(rmBackpack);
		}
		
        dis = point_distance(x,y,xorg, yorg);
        if (dis > 10){
            x += (xorg - x)/10;
            y += (yorg - y)/10;
        }else{
            x = xorg;
            y = yorg;
        }
    }else{
        if (item.in_stomach)
            zone = global.zone_stomach;
        else
            zone = global.zone_bowels;
            
        if (x < zone.x)
            x += 4;
        if (y < zone.y)
            y += 4;
        if (x + width > zone.x + zone.sprite_width)
            x -= 4;
        if (y + height > zone.y + zone.sprite_height)
            y -= 4;
    }
}




