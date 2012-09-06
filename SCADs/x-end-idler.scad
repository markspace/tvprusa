// PRUSA Mendel  
// X-end with idler mount
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>
corection = 1.17; 

z_rod_leadscrew_spacing=31.5;
z_alignment_fix=z_rod_leadscrew_spacing-29.5;

x_belt_center_offset=39.5;
x_belt_alignment_fix = 32.9 - (x_belt_center_offset - bearing_thickness - 1.5);

/**
 * @id x-end-idler
 * @name X end idler
 * @category Printed
 * @using 1 m8spring
 * @using 3 m8nut
 * @using 3 m8washer
 * @using 3 m8washer-big
 * @using 2 m8x30
 */ 
use <x-end.scad>
use <teardrop.scad>

support_beam_offset=(linear==true) ? 6:0;

wall_thickness=5;

xendidler(closed_end=false,curved_sides=true, curved_corners=true, linear_bearing=linear);

module xendidler(closed_end=true,curved_sides=true, curved_corners=false, linear_bearing=false)
{
	difference()
	{
		union()
		{
			xend(closed_end=closed_end,curved_sides=curved_sides, curved_corners=curved_corners, linear_bearing=linear_bearing);
//			import_stl("x-end.stl");

			translate([-25-15.8/2+26.5/2+x_belt_alignment_fix/2,-21,25.3+7.7]) 
			difference()
			{
				cube([26.5-x_belt_alignment_fix,8,14], center=true);
				translate([26.5/2+4.8/2-x_belt_alignment_fix/2,0.75,0]) cylinder(r=6, h=15, $fn=6, center=true);
			}

			translate([-25-15.8/2+24/2+x_belt_alignment_fix/2,12.5+z_alignment_fix-support_beam_offset,25.3+7.7]) 
			cube([24-x_belt_alignment_fix,5,14],center=true);

			difference ()
			{
				translate([-25-15.8/2+wall_thickness/2+x_belt_alignment_fix,-5+z_alignment_fix/2-support_beam_offset/2,15.8/2+(40-15.8/2)/2]) 
				cube([wall_thickness,40+z_alignment_fix-support_beam_offset,40-15.8+15.8/2],center=true);

				translate([-25,-26,15.8/2])
				rotate(90) 
				teardropcentering(6,42);
			}
		}

		translate([-25-15.8/2+(wall_thickness+2+20)/2+x_belt_alignment_fix, -6, 28-3-4.7+12.5]) rotate([0,90,0]) 
	#	cylinder(h=wall_thickness+2+40-x_belt_alignment_fix,r=m8_diameter/2,$fn=9,center=true);

		if(curved_corners==true) 
		{
			xendcorners(5,5,5,5,0);
		}
	}
}


