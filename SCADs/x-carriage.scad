// Gregs PRUSA Mendel  
// X-carriage
// Used for sliding on X axis
// GNU GPL v2
// Greg Frost
//https://github.com/GregFrost/PrusaMendel

include <x-lm8uu-holder.scad>

holder_separation=18;

fan_hole_separation=32; // check
fan_support_block=11;
fan_trap_width=3;
fan_support_thickness=11;
fan_diameter=36;
fan_hole_height=5.5;

belt_clamp_thickness=2; 
belt_clamp_width=m3_diameter+3*belt_clamp_thickness+2;
belt_clamp_hole_separation=10;
belt_clamp_height=m3_diameter+2*belt_clamp_thickness;
belt_clamp_length=belt_clamp_hole_separation+m3_diameter+2*belt_clamp_thickness;

belt_width=6;
belt_thickness=1.5; 
tooth_height=1.5;
tooth_spacing=5;

belt_clamp_channel_height=belt_thickness+tooth_height+belt_clamp_thickness*2;

echo ("belt_clamp_width+0.75",belt_clamp_width+0.75);

for (i=[-1,1])
translate([0,i*(belt_clamp_width+0.75),0])
belt_clamp();

belt_clamp_channel();

gregs_x_carriage();

module gregs_x_carriage(with_fanmount=true) 
{
	difference()
	{
		union ()
		{
			if (with_fanmount) 
			translate([0,-holder_separation-lm8uu_holder_width-fan_support_block/2+3,0])
			fan_mount();

			linear_extrude(height=lm8uu_support_thickness)
			{
			barbell (
				[25,holder_separation/2],
				[25,-holder_separation/2],
				lm8uu_holder_width/2,lm8uu_holder_width/2,12,12);
		

			barbell (
				[25-lm8uu_holder_width/2,holder_separation/2+lm8uu_holder_length-8],
				[-25-13.5+belt_clamp_hole_separation/2,
				1*(lm8uu_holder_length/2+belt_clamp_width/2)],
				8,belt_clamp_width/2,130,130);

			barbell (
				[25-lm8uu_holder_width/2,-holder_separation/2-lm8uu_holder_length+8],
				[-25-13.5+belt_clamp_hole_separation/2,
				-1*(lm8uu_holder_length/2+belt_clamp_width/2)],
				8,belt_clamp_width/2,130,130);

			polygon(points=[
				[-25-lm8uu_holder_width/2,1*(lm8uu_holder_length/2+belt_clamp_width/2)],
				[-25-lm8uu_holder_width/2,-1*(lm8uu_holder_length/2+belt_clamp_width/2)],
				[25-lm8uu_holder_width/2+8,-holder_separation/2-lm8uu_holder_length+8],
				[25-lm8uu_holder_width/2+8,holder_separation/2+lm8uu_holder_length-8]],
				paths=[[0,1,2,3]]);
				
			}

			difference()
			{
				cylinder(r=25+m4_diameter,h=6);
				translate([25-lm8uu_holder_width/2+lm8uu_support_thickness,
					-lm8uu_holder_length,-1])
				cube([lm8uu_holder_width,2*lm8uu_holder_length,8]);
				translate([-25-lm8uu_holder_width/2,-lm8uu_holder_length/2,-1])
				cube([lm8uu_holder_width,lm8uu_holder_length,8]);
			}

			for (i=[-1,1])
			translate([-25-13.5-1,i*(lm8uu_holder_length/2+belt_clamp_width/2)])
			rotate(90*(i+1)+180) 
			belt_clamp_socket ();
		}
	
		for (i=[0:1])
		rotate(180*i)
		for (hole=[-1:1])
		rotate(hole*22)
		translate([0,25,-1])
        polyhole(d=m4_diameter,h=lm8uu_support_thickness*2+2);

	
		translate([0,0,-1])
		cylinder(r=21,h=lm8uu_support_thickness*2+2);

		for (i=[-1,1])
		translate([-25-13.5-1,i*(lm8uu_holder_length/2+belt_clamp_width/2)])
		rotate(90*(i+1)+180) 
		belt_clamp_holes();

		// Cable tie holes.
		for (i=[-1,1])
		translate([25-lm8uu_holder_width/2,
			(holder_separation/2+lm8uu_holder_length*0.7)*i,5])
		rotate([0,-30,0])
		cube([2,4,20],center=true);

		cable_tie_holes();
	}

	difference ()
	{
		union ()
		{
			for(i=[-1,1])
			{
				translate([50/2-lm8uu_holder_width/2,
					i*(lm8uu_holder_length+holder_separation)/2-
					lm8uu_holder_length/2,0])
				render()
				lm8uu_bearing_holder();
			}
			translate([-50/2-lm8uu_holder_width/2,-lm8uu_holder_length/2,0])
			render()
			lm8uu_bearing_holder();
		}

		cable_tie_holes();
	}		
}

module cable_tie_holes ()
{
	// Cable tie holes.
	for (i=[-1,1])
	translate([25-lm8uu_holder_width/2,(holder_separation/2+lm8uu_holder_length*0.7)*i,5])
	rotate([0,-30,0])
	cube([2,4,20],center=true);

	for (i=[-1,1])
	{
		translate([-25+lm8uu_holder_width/2,6.5*i,5])
		rotate([0,30,0])
		translate([2,0,0])
		cube([6,4,20],center=true);
	}
}

module belt_clamp_socket()
{
	difference()
	{
		translate([0,0,belt_clamp_height/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_height],
				center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=belt_clamp_height,center=true);
		}
		belt_clamp_holes();
	}
}

module belt_clamp_channel()
{
	difference()
	{
		translate([0,0,belt_clamp_channel_height/2])
		union()
		{
			cube([belt_clamp_hole_separation,
				belt_clamp_width,belt_clamp_channel_height],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=belt_clamp_channel_height,center=true);
		}

		for(i=[-1,1])
		translate([i*belt_clamp_hole_separation/2,0,-1])
		rotate(360/16)
		polyhole(d=m3_diameter,h=belt_clamp_channel_height+2);

		translate([-belt_width/2,-belt_clamp_width/2-1,
			belt_clamp_channel_height-belt_thickness-tooth_height])
		cube([belt_width,belt_clamp_width+2,belt_thickness+tooth_height+1]);
	}
}

module belt_clamp_holes()
{
	//translate([0,0,belt_clamp_height/2])
	translate([0,0,belt_clamp_height/2])
	{
		for(i=[-1,1])
		translate([i*belt_clamp_hole_separation/2, 0, -belt_clamp_height/2 - 1])
		polyhole(d=m3_diameter,h=belt_clamp_height+2);
	
		rotate([90,0,0])
		rotate(360/16)
        translate([0,0,-belt_clamp_width/2-1])
		polyhole(d=m3_diameter - 0.3 /*tight*/,h=belt_clamp_width+2);

		rotate([90,0,0]) 
		translate([0,0,belt_clamp_width/2-1.7])
        nut(d=m3_nut_diameter - 0.3 /*tight*/ ,h=3.4,horizontal=false);

	}
}

belt_clamp_clamp_height=tooth_height+belt_clamp_thickness*2;


module belt_clamp()
{
	difference()
	{
		translate([0,0,belt_clamp_clamp_height/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,
				belt_clamp_clamp_height],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=belt_clamp_clamp_height,center=true);
		}

		for(i=[-1,1])
		translate([i*belt_clamp_hole_separation/2,0,-1])
		rotate(360/16)
		polyhole(d=m3_diameter,h=belt_clamp_clamp_height+2);

		for(i=[-1:1])
		translate([-belt_width/2,-tooth_spacing/4+i*tooth_spacing,
			belt_clamp_clamp_height-tooth_height])
		cube([belt_width,tooth_spacing/2,tooth_height+1]);
	}
}

module barbell (x1,x2,r1,r2,r3,r4) 
{
	x3=triangulate (x1,x2,r1+r3,r2+r3);
	x4=triangulate (x2,x1,r2+r4,r1+r4);
	render()
	difference ()
	{
		union()
		{
			translate(x1)
			circle (r=r1);
			translate(x2)
			circle(r=r2);
			polygon (points=[x1,x3,x2,x4]);
		}
		translate(x3)
		circle(r=r3,$fa=5);
		translate(x4)
		circle(r=r4,$fa=5);
	}
}

fan_hole_separation=32; // check
fan_support_block=11;
fan_trap_width=3;
fan_support_thickness=11;
fan_diameter=36;
fan_hole_height=5.5;

module fan_mount() 
{
	difference()
	{
		union ()
		{
			translate([0,0,fan_support_block/4])
			cube([fan_hole_separation+fan_support_block,fan_support_thickness,
				fan_support_block/2],center=true);
			
			for (i=[-1,1])
			translate([i*fan_hole_separation/2,0,fan_support_block/2])
			rotate([90,0,0])
			cylinder(r=fan_support_block/2,h=fan_support_block,center=true,$fn=20);
			
			translate([0,0,fan_support_block/2])
			cube([fan_hole_separation,fan_support_thickness,fan_support_block],
				center=true);
			translate([0,6,lm8uu_support_thickness/2])
			cube([fan_hole_separation+fan_support_block,fan_support_thickness+12,
				lm8uu_support_thickness],center=true);
		}
		for(i=[-1,1])
		{
			translate([i*fan_hole_separation/2,0,fan_hole_height])
			{
				rotate([90,0,0])
				rotate(180/8)
                translate([0,0,-fan_support_thickness/2-1])
				polyhole(d=m3_diameter,h=fan_support_thickness+2);
				translate([0,0,0])
				rotate([90,0,0])
				rotate([0,0,180/6])
                translate([0,0,-fan_trap_width/2])
				nut(d=m3_nut_diameter,h=fan_trap_width, horizontal=false);
				translate([0,0,-(fan_hole_height+1)/2])
				cube([m3_nut_diameter,fan_trap_width,
					fan_hole_height+1],center=true);
			}
		}
		translate([0,0,fan_hole_separation/2+fan_hole_height])
		rotate([-90,0,0])
		cylinder(r=fan_diameter/2,h=fan_support_thickness+2,center=true);
	}
}

function triangulate (point1, point2, length1, length2) = 
point1 + 
length1*rotated(
atan2(point2[1]-point1[1],point2[0]-point1[0])+
angle(distance(point1,point2),length1,length2));

function distance(point1,point2)=
sqrt((point1[0]-point2[0])*(point1[0]-point2[0])+
(point1[1]-point2[1])*(point1[1]-point2[1]));

function angle(a,b,c) = acos((a*a+b*b-c*c)/(2*a*b)); 

function rotated(a)=[cos(a),sin(a),0];
