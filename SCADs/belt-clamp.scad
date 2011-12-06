// PRUSA Mendel  
// Belt clamp
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>

/**
 * @id belt-clamp
 * @name Belt clamp
 * @category Printed
 */ 

hole_spacing = 18;
hole_padding = 3;

belt_notch_width = 7;
belt_notch_length = belt_pitch/2+0.1;
belt_notch_depth = 1.5;

clamp_height = 7;
tensioner_height=m3_nut_diameter+2+2*belt_notch_depth;
width = 2*hole_padding + hole_spacing + m3_diameter ;
depth = m3_diameter + 2* hole_padding;

notches = ceil(depth/belt_pitch)/2;

beltclamp();
translate([0,-(depth+2),0]) beltclamp();
translate([0,-2*(depth+2),0]) beltclamp();

translate([0,depth+2,0]) 
belt_tensioner(tensioner_height);

module beltclamp(){
	difference(){

		
		body (clamp_height);

		//Belt notches
		translate(v = [0,0,clamp_height ]){
			for ( i = [-notches:notches]) {
				translate(v = [0,i*belt_pitch,0])cube(size = [belt_notch_width, belt_notch_length, 2*belt_notch_depth], center = true);
			}
		}
	}
}

module body (hght) {
	difference(){	
		//Clamp body
		union(){
			translate(v = [0,0,hght/2]) cube([hole_spacing, depth, hght], center=true);
			translate(v = [-hole_spacing/2, 0, 0]) cylinder(r=depth/2,h=hght);
			translate(v = [hole_spacing/2, 0, 0]) cylinder(r=depth/2,h=hght);
		}

		//Holes
		translate(v = [-hole_spacing/2, 0, -1])polyhole(m3_diameter, hght+2);
		translate(v = [hole_spacing/2, 0, -1]) polyhole(m3_diameter, hght+2);
	}
}

module belt_tensioner(hght){
	difference() {
		body (hght);

		translate([0,depth/2+1,m3_nut_diameter/2+1]) rotate([90,0,0]) nut(m3_nut_diameter,m3_nut_thickness+1);
		translate([0,depth/2+1,m3_nut_diameter/2+1]) rotate([90,0,0]) polyhole(m3_diameter, depth+2);
	
		translate([0,0,hght/2+m3_nut_diameter/2+2]) cube([belt_notch_width,depth+2,hght-m3_nut_diameter-2+2],center=true);
	}
}
	

