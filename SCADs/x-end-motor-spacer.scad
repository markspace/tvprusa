// PRUSA Mendel  
// X-end with NEMA 17 motor mount
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>
corection = 1.17; 

/**
 * @id x-end-motor
 * @name X end motor
 * @category Printed
 * @using 2 bushing
 * @using 4 m3x10xhex
 * @using 4 m3washer
 * @using 1 m8spring
 * @using 2 m8nut
 */


rotate ([0,-90,0])
difference ()
	{
	positioned_motor_mount();
	positioned_motor_mount_holes();
	}


// GregFrosts stuff
nema17_hole_spacing=1.2*25.4; 
nema17_width=1.7*25.4;
thickness=5;
nema17_support_d=nema17_width-nema17_hole_spacing;
motor_mount_rotation=[0,0,0];
motor_mount_translation=[0,0,0];
// motor_mount_translation=[44-thickness,8,23.5-4.7-12+24.5];

top_corner=motor_mount_translation+[thickness,nema17_width/2,nema17_width/2];
bridge_length=top_corner[0]-9;
bridge_shear=0.48;

module positioned_motor_mount()
{
	translate(motor_mount_translation)
	union()
	{
		rotate([0,90,0])
		motor_mount ();
	}
}

module positioned_motor_mount_holes()
{
	translate(motor_mount_translation)
	rotate([0,90,0])
	motor_mount_holes ();
}

module motor_mount ()
{
	rotate(motor_mount_rotation)
	{
		for (hole=[1,2])
		rotate([0,0,90*hole])
		linear_extrude(height=thickness)
		translate(-nema17_hole_spacing*[1,1,0]/2)
		barbell (nema17_support_d/2,
		nema17_support_d/2,20,60,nema17_hole_spacing);
	}
}

module motor_mount_holes ()
{
	// Motor mount holes. 
	translate([0,0,-1])
	rotate(motor_mount_rotation)
	{
		for (hole=[3:5])
		rotate([0,0,90*hole])
		translate(nema17_hole_spacing*[1,1,0]/2)
		rotate(360/16)
		cylinder(h=thickness+2,r=4.4/2,$fn=8);
		
	}
	
	translate([-7/2-0.5-(nema17_width/2-nema17_hole_spacing/2),0,0])
	rotate(270)
	translate([0,0,-1])
	cube([nema17_width/2,nema17_width/2,thickness+2]);
}

module barbell (r1,r2,r3,r4,separation) 
{
	x1=[0,0];
	x2=[separation,0];
	x3=triangulate (x1,x2,r1+r3,r2+r3);
	x4=triangulate (x2,x1,r2+r4,r1+r4);
	# render()
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

