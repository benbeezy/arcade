/***************************************************
PLEASE UNDERSTAND:
Everything in this file is measured in mm becuase the
matric system is far better than our american way of
doing things.

This arcade machine can be made out of really
anything, it should be cool to be cut on any large CNC
laser or mill.
***************************************************/

/***************************************************
CURRENT ISSUES:
1) no finger joints not a huge issue if you are okay using screws
2) I have not made one my self from these files, so make sure you look over everything and test before doing a full sized machine
3) it does not yet work to optamise the number of parts on a 4x8 sheet you have to render each part and place them on the cut file your self
4) It does not programatically tell you how many sheets of material to buy before hand
5) I don't currently have a way of cutting out vector images to fit the pieces exact, for engraving on here just yet
6) The default settings might be WAY off base I have no idea, again make sure you look at everything before hitting cut
***************************************************/

material_thickness			= 8;
control_height				= 200;
control_deck_depth			= 50;
control_depth				= 20;
full_depth						= 150;
full_height					= 500;
full_width						= 200;
vesa_mount					= true;
custom_vesa_y				= 400;
custom_vesa_x				= 300;
screen_tilt					= 20;
number_of_players			= 2;
buttons_per_player			= 6;
pin_ball_buttons				= true;
speakers						= 2;
speaker_width				= 45;
speaker_height				= 45;
speaker_angle				= 20;

screen_bezel_inset			= 0;

coin_dour						= true;
coin_dour_width				= 50;
coin_dour_height			= 80;

players						= 2;
button_hole					= 10;
button_spacing				= 5;
joystick_hole					= 15;
joystick_spacing				= 20;

space_between_players		= 40;

finger_joint					= true;
finger_spacing				= 20;
finger_length					= 20;

marquee_height				= 50;
marquee_angle				= 25;



//controller_front();
//bottom_front();
side();
//screen_mount();


//fingers_out_square(200,200,true);


module side(){
	translate([0,control_height-control_depth,0]) square([full_depth+control_depth,control_deck_depth]);
	square([full_depth,control_height]);
	difference(){
		translate([0,control_height]) square([full_depth,full_height-control_height]);
		translate([full_depth,control_height-screen_bezel_inset])rotate([0,0,screen_tilt]) square([full_depth,full_height]);
	}
	translate([0,control_height-control_depth,0]) square([full_depth+control_depth,control_deck_depth]);
	
	
	intersection(){
	translate([0,(full_height-marquee_height)-((full_depth*sin(marquee_angle))/sin(90-marquee_angle)),0]) rotate([0,0,marquee_angle])  square([full_depth*2,full_depth*2]);
		square([full_depth,full_height]);
	}
	
}


module fingers_out_square(x,y,center){
	difference(){
		square([x+material_thickness,y+material_thickness], center=center);
		for (a =[-x:x]){
			translate([x/2,a*(finger_spacing+finger_length)]) square([material_thickness,finger_length], center=true);
			translate([-x/2,a*(finger_spacing+finger_length)]) square([material_thickness,finger_length], center=true);
		}
		for (b =[-y:y]){
			!translate([b*(finger_spacing+finger_length),y/2]) square([finger_length,material_thickness], center=true);
			translate([b*(finger_spacing+finger_length),-y/2]) square([finger_length,material_thickness], center=true);
		}
	}
}

module fingers_in_square(x,y,center){
	difference(){
		square([x,y], center=center);
		for (a =[-x:x]){
			translate([(x/2)-material_thickness/2,a*(finger_spacing+finger_length)]) square([material_thickness,finger_length], center=true);
			translate([(-x/2)+material_thickness/2,a*(finger_spacing+finger_length)]) square([material_thickness,finger_length], center=true);
		}
		for (b =[-y:y]){
			!translate([b*(finger_spacing+finger_length),(y/2)-material_thickness/2]) square([finger_length,material_thickness], center=true);
			#translate([b*(finger_spacing+finger_length),(-y/2)+material_thickness/2]) square([finger_length,material_thickness], center=true);
		}
	}
}


module bottom_front(){
	module coin_dour(){
		square([coin_dour_width,coin_dour_height], center=true);
	}
	module panel(){
		square([full_width,control_height-control_depth], center=true);
	}
	if (coin_dour==true){
		difference(){
			panel();
			coin_dour();
		}
	}
}

module controller_front(){
	square([full_width,control_deck_depth], center=true);
}

module screen_mount(){
	module vesa(){
		translate([-75/2,75/2]) circle(d=6);
		translate([-75/2,-75/2]) circle(d=6);
		translate([75/2,75/2]) circle(d=6);
		translate([75/2,-75/2]) circle(d=6);

		translate([-100/2,100/2]) circle(d=6);
		translate([-100/2,-100/2]) circle(d=6);
		translate([100/2,100/2]) circle(d=6);
		translate([100/2,-100/2]) circle(d=6);
		
		translate([-200/2,200/2]) circle(d=6);
		translate([-200/2,-200/2]) circle(d=6);
		translate([200/2,200/2]) circle(d=6);
		translate([200/2,-200/2]) circle(d=6);

		translate([-400/2,400/2]) circle(d=6);
		translate([-400/2,-400/2]) circle(d=6);
		translate([400/2,400/2]) circle(d=6);
		translate([400/2,-400/2]) circle(d=6);
		
		translate([-custom_vesa_x/2,custom_vesa_y/2]) circle(d=6);
		translate([-custom_vesa_x/2,-custom_vesa_y/2]) circle(d=6);
		translate([custom_vesa_x/2,custom_vesa_y/2]) circle(d=6);
		translate([custom_vesa_x/2,-custom_vesa_y/2]) circle(d=6);
	}
	module panel(){
		square([full_width, full_height-control_height-marquee_height], center=true);
	}
	if (vesa_mount==true){
		difference(){
			panel();
			vesa();
		}
	} else {
		panel();
	}
}