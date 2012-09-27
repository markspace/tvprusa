// PRUSA Mendel  
// X-end prototype for
// GNU GPL v3
// Josef Prusa
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel
// Thanks to GregFrost for refactoring!

include <configuration.scad>
correction = 1.17; 
use <bushing.scad>
use <teardrop.scad>

z_rod_leadscrew_spacing=31.5;
alignment_fix=z_rod_leadscrew_spacing-29.5;

axis_diameter_real=4;
axis_diameter_larger=4.2;
pressure_pad_height=2.5;
add_strength=false;
xend_height=15.8;
xend_length=40+alignment_fix;
solid_end_width=3;
slot_width=1;

pad_height=4.9;
pad_width=7;
pad_connector_height=3.3;
bushing_support_width=17;
rod_support_width=10;
pad_groove_depth=0.8;

m8cornerdiameter = nutcornerdiameter(m8_nut_diameter);

module xend_side(closed_end=true, curved_sides=false, add_strength=false)
{
	translate([25,0,0])
	difference ()
	{
		union()
		{
			if (curved_sides)
			{
				for (i=[0:1])
				rotate(90) 
				rotate([180*i,0,0])
				teardrop(r=xend_height/2,h=xend_length);
			}
			else
			{
				// Base with cut sides
				difference ()
				{
					// Base
					translate([0,xend_length/2,0])
					cube([xend_height,xend_length,xend_height],center=true);
	
					// Cutting sides
					for (i=[0:1])
					translate([0,xend_length/2,0])
					rotate(i*180)
					{
						translate([-12.5,0,2]) 
						rotate([0,25,0]) 
						cube([10,xend_length+2,20],center=true);
	
						translate([-13,0,0]) rotate(a = [0,-10,0]) 
						cube([10,xend_length+2,20],center=true);
					}
				}
			}

			// Support beams from side to center of x-end
			translate([-26,xend_length-bushing_support_width,-xend_height/2]) cube([26,bushing_support_width,xend_height]);
			translate([-26,0,-xend_height/2]) cube([26,rod_support_width,xend_height]);
		}

		difference ()
		{
			union ()
			{
				// Teardrop cutout				
				translate([0,-1,0]) rotate(90) teardrop45(axis_diameter_larger, closed_end?xend_length-solid_end_width+1:xend_length+2);

				// Main holes thru the bottom
				translate([axis_diameter_larger,0,0]) rotate([0,8,0]) translate([-axis_diameter_larger,solid_end_width,-xend_height/2-1]) cube([axis_diameter_larger, xend_length-2*solid_end_width, xend_height/2+1]);
				translate([-axis_diameter_larger,0,0]) rotate([0,-8,0]) translate([0,solid_end_width,-xend_height/2-1]) cube([axis_diameter_larger, xend_length-2*solid_end_width, xend_height/2+1]);

				if (closed_end)
				{
					translate([0,xend_length-solid_end_width+1.5,0]) rotate([90,0,0]) cylinder(r=nutcornerdiameter(m3_nut_diameter)/2, h=3,$fn=6);
					translate([0,xend_length+1,0]) rotate([90,0,0]) cylinder(r=nutcornerdiameter(m3_diameter)/2-0.2, h=solid_end_width+2,$fn=6);
				}

			}

			//Pad connector
			translate([-axis_diameter_larger-1,solid_end_width+slot_width,-xend_height/2])
			cube([axis_diameter_larger, xend_length-2*solid_end_width-2*slot_width, pad_connector_height]);

			difference()
			{
				translate([-pad_width/2,solid_end_width+slot_width,-xend_height/2])
				cube([pad_width, xend_length-2*solid_end_width-2*slot_width, pad_height]);
				
				// Cutout groove in pressure pad
				// Gregs
				translate([0,solid_end_width+slot_width-1,-xend_height/2+pad_height+m8_diameter/2-pad_groove_depth]) rotate([-90,0,0]) rotate(180/20) cylinder(r=m8_diameter/2,h=xend_length-2*solid_end_width-2*slot_width+2,$fn=30);
				// Prusa
				translate([0,0,1.1]) rotate([-90,0,0])cylinder(r=axis_diameter_larger,h=closed_end?xend_length-1:xend_length+2, $fn=30);

				translate([axis_diameter_larger,0,0])
				rotate([0,8,0])
				translate([-slot_width,solid_end_width,-xend_height/2-1])
				cube([slot_width,xend_length-2*solid_end_width,xend_height/2+1]);
				// hack for a taper opening
				translate(v=[0,15,1.1]) rotate(a=90,v=[1,0,0]) cylinder(r1=axis_diameter_larger, r2=axis_diameter_larger+1.5,h=15, $fn=30);
			}
		}

		if (add_strength)
		{
			for (i=[0:5])
			translate([-axis_diameter_larger+2,5+2.5+5*i,-axis_diameter_larger]) 
			cylinder(h=7,r=0.4,$fn=6,center=true);

			for (i=[0:6])
			translate([-axis_diameter_larger-2,5+5*i,-axis_diameter_larger])
			cylinder(h=7,r=0.4,$fn=6,center=true);
		}

		if (!closed_end)
		{
			translate([0,xend_length-1.5-solid_end_width,0])
			cylinder(r=m3_diameter/2, h=xend_height+2,$fn=10,center=true);
		}
	}
}

module xend(closed_end=true, curved_sides=false, curved_corners=false, linear_bearing=false)
{

	if(linear_bearing==true) translate([0,alignment_fix,0]) z_linear_bearings();
	if(linear_bearing==false) translate([0,alignment_fix,0]) z_bushings();	
	difference()
	{
		union ()
		{
			translate(v = [0,-25,xend_height/2])
			{
				xend_side(closed_end=closed_end,curved_sides=curved_sides);
				mirror([1,0,0]) 
				xend_side(closed_end=closed_end,curved_sides=curved_sides);
			}	

			// Slider.
//			translate([0,6.5,30]) 
//			cube([15.5+2*thin_wall,17,60],center=true);

			// Strengthening beam between nut trap and bushing
			translate([0,-6+alignment_fix/2,31]) 
			cube([4,12+alignment_fix,18],center=true);

			//Nut Trap
			translate([0,-20,0]) 
			cylinder(h=40,r=m8cornerdiameter/2+thin_wall,$fn=6);

		}

		if(curved_corners==true) xendcorners(5,5,5,5,0);

		// Slider cutout. 
		translate([0,10+alignment_fix,8]) 
		cube([22.5,22.5,20],center=true);

		//Rod hole.
		difference()
		{
			translate([0,-20,39.5-45]) nut(m8_nut_diameter,90);
			translate([0,-20,8.5]) cylinder(h=4,r=m8_nut_diameter/2+thin_wall,$fn=6,center=true);
		}
		translate([0,-20,52-45]) 
		polyhole(m8_diameter+2,90);
	}
}

module xendcorners(dia1, dia2, dia3, dia4, height=0)
{
	translate(v = [0,35,24.5]) 
	union()
	{ 
		//round corners
		translate(v = [33.1, -60.1, -25]) rotate(a=[0,0,90]) roundcorner(dia1);
		translate(v = [33.1, -19.9+alignment_fix, -25]) rotate(a=[0,0,-180]) roundcorner(dia2);
		translate(v = [-33.1,-60.1,-25]) rotate(a=[0,0,0]) roundcorner(dia3);
		translate(v = [-33.1, -19.9+alignment_fix, -25]) rotate(a=[0,0,-90]) roundcorner(dia4);
	}
}
//xendcorners(5,5,5,5,0);
//difference(){
xend(closed_end=true, curved_sides=false, linear_bearing=true, curved_corners=false);
//translate(v = [15, -40, 0]) cube(size = [20,100,20]);

//translate(v = [-15-20, -40, 0]) cube(size = [20,100,20]);

//translate(v = [-50, -45, 0]) cube(size = [100,40,100]);
//}

//xend_side();
