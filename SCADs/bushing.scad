// PRUSA Mendel  
// Bushings
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>

/**
 * @id bushing
 * @name Bushing
 * @category Printed
 * @id bushing
 */ 

/*rodsize = bushing_rodsize;
outerDiameter = bushing_outerDiameter;
length = bushing_length;
type = bushing_type;*/


module bushing(stiff, length=11){
	difference(){
		union(){
			translate(v=[-7.5,-8,0])cube(size = [15,8,length]);
			cylinder(h = length, r=7.5);
		}
	//cutout inside
	//Opening
	rotate(a=[0,0,45]) translate(v=[1,1,-1]) cube(size = [16,16,length+2]);
	//Cutouts to make it more bendy
	if(stiff){
		translate(v=[-4.8,-6,-1]) cube(size = [0.8,6,length+2]);
		translate(v=[4,-6,-1]) cube(size = [0.8,6,length+2]);
	}else{
		translate(v=[-4.8,-8,-1]) cube(size = [0.8,8,length+2]);
		translate(v=[4,-8,-1]) cube(size = [0.8,8,length+2]);
	}
	translate(v=[0,5,(length+2)/2]) cube(size = [7,8,length+2], center=true);
	translate(v=[0,0,-1]) cylinder(h = length+2, r=5);
	}
}


module standard_bushing(){

difference(){translate(v=[0,5,8])rotate(a=[90,0,0]){
bushing(false, 10);
translate(v=[-7,-13,0])cube(size = [14,5,10]);
translate(v=[-2,-13,-3])cube(size = [4,5,16]);
translate(v=[-2,-12,-3])cube(size = [4,7.5,2]);
translate(v=[-2,-12,11])cube(size = [4,7.5,2]);
}
translate(v=[-3,-1,-16])rotate(a=[45,0,0])cube(size = [6,5,16]);

mirror([ 0, 1, 0 ]) translate(v=[-3,-1,-16])rotate(a=[45,0,0])cube(size = [6,5,16]);}
}


// Includes small cutouts for better prints
module vertical_bushing(stiff, length){
difference(){
bushing(stiff, length);
translate(v=[-5,0,-1]) cube(size = [10,2.5,length+2]);
}
}


//vertical_bushing(true, 11);

module z_bushings(){
// STUFF FOR X-ENDS
difference(){
// Slider.
translate([0,6.5,30]) 
cube([23,17,60],center=true);
// Slider cutout.
translate([0,10,32.5]) 
cube([17,17,70],center=true);
}
union(){translate([0,9.5,0])vertical_bushing(true,13);
	//translate([0,4,0.5])cube(size = [8,2,1], center = true);
	//translate([0,4,12.5])cube(size = [8,2,1], center = true);
	translate([0,9.5,48])vertical_bushing(true,13);
	//translate([0,4,48+0.5])cube(size = [8,2,1], center = true);
	//translate([0,4,48+12.5])cube(size = [8,2,1], center = true);
	translate([0,9.5,32])
	{
		difference()
		{
			bushing(true,16);
			translate([0,3,2]) 
			rotate([45,0,0])
			cube([16,30,16], center=true);
		}
	}
}
}

//z_bushings();
z_linear_bearings();
//lm8uu_bearing_holder();

clearance=0.2;

lm8uu_diameter=linear_bearing_diameter+clearance;
lm8uu_length=linear_bearing_length+clearance;

lip_height=2;
lip_depth=2;
holder_thickness=2.3;

z_linear_bearings_height = 3*lip_height+2*lm8uu_length;

module z_linear_bearings(){
	translate(v=[0,9.5,0]) rotate(a=[0,0,90]){
		difference(){
			union(){
				//main block
				translate(v=[-5,0,z_linear_bearings_height/2]) cube(size = [lm8uu_diameter/2+holder_thickness,2*(lm8uu_diameter/2+holder_thickness),z_linear_bearings_height], center = true);
			
				//holder for main block in x-end
				translate(v=[-5,0,15.8/2]) cube(size = [12,23,15.8], center = true);
				translate(v=[0,0,0]) cylinder(h = z_linear_bearings_height, r=lm8uu_diameter/2+holder_thickness, $fn=60);
			}
	
			//main axis
			translate(v=[0,0,-2]) cylinder(h = z_linear_bearings_height+4, r=lm8uu_diameter/2, $fn=50);
		
			//main cut
			translate(v=[10,0,z_linear_bearings_height/2]) cube(size = [20,12,z_linear_bearings_height+2], center = true);

			//smooth entry cut
			translate(v=[14,0,z_linear_bearings_height/2]) rotate(a=[0,0,45]) cube(size = [20,20,z_linear_bearings_height+2], center = true);
			translate(v=[0,0,14.5+2]) ziptie();
			translate(v=[0,0,z_linear_bearings_height-(12+2)-5]) ziptie();
		}
		translate(v=[-(10-5.5)/2-5.5,0,lip_height/2]) cube(size = [10-5.5,20,lip_height], center = true);
		translate(v=[-(10-5.5)/2-5.5,0,lm8uu_length+3/2*lip_height]) cube(size = [10-5.5,20,lip_height], center = true);
		translate(v=[-(10-5.5)/2-5.5,0,z_linear_bearings_height-lip_height/2]) cube(size = [10-5.5,20,lip_height], center = true);

	}
}

module ziptie(){
difference(){
translate(v=[0,0,0]) cylinder(h = 3.9, r=10.3);
translate(v=[0,0,0]) cylinder(h = 5, r=10-1, $fn=50);
translate(v=[0,0,3]) cylinder(h = 1, r1=10-1, r2=10.2, $fn=50);
}}


// Gregs

lm8uu_support_thickness=3.2; 
lm8uu_end_diameter=m8_diameter+2*clearance;

lm8uu_holder_width=lm8uu_diameter+2*lm8uu_support_thickness;
lm8uu_holder_length=lm8uu_length+2*lm8uu_support_thickness;
lm8uu_holder_height=lm8uu_diameter*0.75+lm8uu_support_thickness;
lm8uu_holder_gap=(lm8uu_holder_length-6*lm8uu_support_thickness)/2;
module lm8uu_bearing_holder()
{
	translate([-lm8uu_holder_width/2,-lm8uu_holder_length/2,-5])difference()
	{
		cube([lm8uu_holder_width,lm8uu_holder_length,lm8uu_holder_height]);
		translate([lm8uu_holder_width/2,0,lm8uu_holder_width/2])
		rotate([-90,0,0])
		translate([0,0,5])
		cylinder(r=lm8uu_diameter/2,h=lm8uu_length,$fn=40);

		translate([lm8uu_holder_width/2,0,lm8uu_holder_width/2])
		rotate([-90,0,0])
		translate([0,0,-1])
		{
			cylinder(r=lm8uu_end_diameter/2,h=lm8uu_holder_length+2,$fn=40);
			translate([-lm8uu_end_diameter/2,-lm8uu_end_diameter,0])
			cube([lm8uu_end_diameter,lm8uu_end_diameter,lm8uu_holder_length+2]);
		}

		translate([-1,2*lm8uu_support_thickness,lm8uu_support_thickness])
		cube([lm8uu_holder_width+2,lm8uu_holder_gap,
			lm8uu_holder_height-lm8uu_support_thickness+1]);

		translate([-1,4*lm8uu_support_thickness+lm8uu_holder_gap,
			lm8uu_support_thickness])
		cube([lm8uu_holder_width+2,lm8uu_holder_gap,
			lm8uu_holder_height-lm8uu_support_thickness+1]);
	}
}	

module lm8uu_bearing_cut()
	{
		translate([-lm8uu_holder_width/2,-lm8uu_holder_length/2,-5])cube([lm8uu_holder_width,lm8uu_holder_length,lm8uu_holder_height]);
	}
