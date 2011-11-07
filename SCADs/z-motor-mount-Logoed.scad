// PRUSA Mendel  
// Z motor mount
// Used for mounting Z motors
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel
include <configuration.scad>
include <OpenScadFont.scad>


/**
 * @id z-motor-mount
 * @name Z motor mount
 * @category Printed
 * @using 2 m3x25xhex
 * @using 2 m3nut
 * @using 2 m3washer
 * @using 4 m8nut
 * @using 4 m8washer
 * @using 1 rod-clamp
 */


 $fs=0.5;
Side="left";					// Mounted on 'left' or 'right'
Plaque_type="Serial";			// Include either the 'Logo' or 'Serial'

Logo_Source="TVRR.dxf";		// Source file for Logo
Serial=["0","1","#","0","1"];		// Number for Serial




module zmotormount(){
difference(){
union(){
translate(v=[2.5,0,0]) cube(size = [55,60,16], center = true);
translate(v=[2.5,0,-4]) cube(size = [55,74.5-16,8], center = true);
translate(v=[-25,29.25,0]) rotate(a=[0,90,0]) cylinder(h = 55, r=8, $fn=30);
translate(v=[-25,-29.25,0]) rotate(a=[0,90,0]) cylinder(h = 55, r=8, $fn=30);
}
translate(v=[-2.1,0,2.8]) cube(size = [46,43,13], center = true);

// reducing the material
translate(v=[10.5-2.5,34.5,-4]) cube(size = [25,20,30], center = true);
translate(v=[10.5-2.5,-34.5,-4]) cube(size = [25,20,30], center = true);
translate(v=[-10,0,0]) translate(v=[5.5,24.5,-10]) rotate(a=[0,0,45]) cube(size = [20,20,30]);
translate(v=[-10,0,0]) translate(v=[5.5,-24.5,-10]) rotate(a=[0,0,225]) cube(size = [20,20,30]);

// Nema 17
rotate ([0,0,45]) translate([20,0,0]) cube(size = [9,3.2,25], center = true);
rotate ([0,0,-45]) translate([20,0,0]) cube(size = [9,3.2,25], center = true);
rotate ([0,0,135]) translate([20,0,0]) cube(size = [9,3.2,25], center = true);
rotate ([0,0,-135]) translate([20,0,0]) cube(size = [9,3.2,25], center = true);
translate(v=[0,0,-10])polyhole(26,20);

translate(v=[30,0,-10]) cylinder(h = 20, r=4.2);
translate(v=[-26,29.25,0]) rotate(a=[0,90,0]) cylinder(h = 58, r=m8_diameter/2);
translate(v=[-26,-29.25,0]) rotate(a=[0,90,0]) cylinder(h = 58, r=m8_diameter/2);


translate(v=[16,7,0]) rotate(a=[0,90,0]) polyhole(m3_diameter,15);
translate(v=[16,-7,0]) rotate(a=[0,90,0]) polyhole(m3_diameter,15);
translate(v=[0,7,0]) rotate(a=[0,90,0]) rotate(a=[0,0,30]) nut(m3_nut_diameter, 24, true);
translate(v=[0,-7,0]) rotate(a=[0,90,0]) rotate(a=[0,0,30]) nut(m3_nut_diameter, 24, true);

}
}

module plaque(){


		difference(){
			minkowski(){
				cube([40,2.5,15],center=true);
				translate([0,0,00]){sphere(r=1.48);}
			
		if (Plaque_type=="Logo"){rotate([90,0,180]){translate([-17.5,-6.5,3]){scale([0.75,0.75,1]){linear_extrude(file=Logo_Source, height=5, center=true);}}}}}
		if (Plaque_type=="Serial") { translate([12,0.5,0]) rotate([-90,90,0]) scale([1.25,1.25,1]) fnt_str(Serial,5,1,5);}
		}
}

union(){
	zmotormount();
	if (Side=="left")	{ translate([1,-24.25,15])	{rotate([0,0,180])	{plaque();}}}
	if (Side=="right") 	{ translate([1,24.25,15])	{rotate([0,0,000])	{plaque();}}}
}