// PRUSA Mendel  
// Configuration test
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>

/**
 * @id calibration
 * @name Configuration test
 */

//configurationtest();

nuttests();
//rotate([0,0,180]) 
//nutslottests();

module nuttests()
{	
	union()
	{
		nuttest(m8_diameter, m8_nut_diameter, m8_nut_thickness);
		translate([m8_nut_diameter/cos(30)*1.5,0,0]) 
			nuttest(m4_diameter, m4_nut_diameter, m4_nut_thickness);
		translate([(m8_nut_diameter+m4_nut_diameter)/cos(30)*1.5,0,0]) 
			nuttest(m3_diameter, m3_nut_diameter, m3_nut_thickness);
	}
}

module nutslottests()
{
	union()
	{
		nutslottest(m8_diameter, m8_nut_diameter, m8_nut_thickness);
		translate([m8_nut_diameter/cos(30)*1.5,0,0]) 
			nutslottest(m4_diameter, m4_nut_diameter, m4_nut_thickness);
		translate([(m8_nut_diameter+m4_nut_diameter)/cos(30)*1.5,0,0]) 
			nutslottest(m3_diameter, m3_nut_diameter, m3_nut_thickness);

	}
}

module nuttest(hole_d, nut_d, nut_t)
{
	union()
	{
		translate([nut_d/cos(30)*1.5/2,nut_d/cos(30)*1.5/2,(nut_t+2)/2]) nutrecess(hole_d, nut_d, nut_t, true);
		translate([nut_d/cos(30)*1.5/2,-(nut_t+2)/2,2+nut_d/cos(30)*1.5/2]) rotate([90,0,0]) nutrecess(hole_d, nut_d, nut_t, false);
		translate([0,-(nut_t+2),0])cube([nut_d/cos(30)*1.5,nut_t+2,2]);
	}
}

module nutslottest(hole_d, nut_d, nut_t)
{
	union()
	{
		translate([nut_d/cos(30)*1.5/2,nut_d/cos(30)*1.5/2,(nut_t+4)/2]) rotate([0,0,180])nutslot(hole_d, nut_d, nut_t, true);
		translate([nut_d/cos(30)*1.5/2,-(nut_t+2)/2,nut_d/cos(30)*1.5/2]) rotate([-90,0,0]) nutslot(hole_d, nut_d, nut_t, false);
	}
}

module nutrecess(hole_d, nut_d, nut_t, horizontal)
{
	translate([0,0,-nut_t/2])
	difference()
	{
		translate([0,0,nut_t/2]) cube([nut_d/cos(30)*1.5, nut_d/cos(30)*1.5, nut_t+2], center=true);
		nut(d=nut_d, h=nut_t+2, horizontal = horizontal);
		translate([0,0,-1.5]) polyhole(d=hole_d, h=nut_t+3);
	}
}

module nutslot(hole_d, nut_d, nut_t, horizontal)
{
	difference()
	{
		cube([nut_d/cos(30)*1.5, nut_d/cos(30)*1.5, nut_t+4], center=true);
		rotate([0,0,30])translate([0,0,-nut_t/2]) nut(d=nut_d, h=nut_t, horizontal = horizontal);
		translate([0,-nut_d,0])cube([nut_d, nut_d*2, nut_t], center=true);
	}
}

module configurationtest()
{
	difference()
	{
		union()
		{
			rotate( a = [0, 0, 30] ) cylinder( h = 10, r = ( m8_nut_diameter / 2 ) + 4, $fn = 6 );
			translate( v = [( ( ( m8_diameter / 2 ) + 3 ) * 2 + ( m3_diameter / 2 ) + 2 + ( ( ( m3_diameter / 2 ) + 2 ) * 2 ) / 2 ) / 2, 0,5] ) cube( size = [( ( m8_diameter / 2 ) + 3 ) * 2 + ( m3_diameter / 2 ) + 2 + ( ( ( m3_diameter / 2 ) + 2 ) * 2 ) / 2, ( ( m8_nut_diameter / 2 ) + 4 ) * 2, 10], center = true );

			translate( v = [( ( m8_diameter / 2 ) + 3 ), ( m8_nut_diameter / 2 ) + 2, ( ( m8_diameter ) + 15 ) / 2]) cube( size = [( ( m8_diameter / 2 ) + 3 ) * 2, 4, ( m8_diameter ) + 15], center = true );
			//translate( v = [( m8_diameter / 2 ) + 3, ( m8_nut_diameter / 2 ) + 4, ( m8_diameter / 2 ) + 10] ) rotate( a = [90, 0, 0] ) cylinder( h = 4, r = ( m8_diameter / 2 ) + 3 );

			translate( v = [( ( m8_diameter / 2 ) + 3 ) * 2 + ( m3_diameter / 2 ) + 1.9, ( m8_nut_diameter / 2 ) + 2, ( ( m8_diameter ) + 15 ) / 2] ) cube( size = [( ( m3_diameter / 2 ) + 2.1 ) * 2, 4, ( m8_diameter ) + 15], center = true);
			//translate( v = [( ( m8_diameter / 2 ) + 3 ) * 2 + ( m3_diameter / 2 ) + 2, ( m8_nut_diameter / 2 ) + 4, ( m8_diameter / 2 ) + 10] ) rotate( a = [90, 0, 0] ) cylinder( h = 4, r = ( m3_diameter / 2 ) + 2 );
		}
		translate( v = [( m8_diameter / 2 ) + 3, ( m8_nut_diameter / 2 ) + 5, ( m8_diameter / 2 ) + 10] ) rotate( a = [90, 0, 0] ) cylinder( h = 6, r = ( m8_diameter / 2 ) );
		translate( v = [( ( m8_diameter / 2 ) + 3 ) * 2 + ( m3_diameter / 2 ) + 2, ( m8_nut_diameter / 2 ) + 5, ( m8_diameter / 2 ) + 10] ) rotate( a = [90, 0, 0] ) cylinder( h = 6, r = ( m3_diameter / 2 ) );
		translate( v = [0, 0, -1] ) cylinder( h = 15, r = ( m8_diameter / 2 ) );
		translate( v = [( m8_nut_diameter / 2 ) + ( m3_nut_diameter / 2 ) + 2, 0, -1] ) cylinder( h = 15, r = ( m3_diameter / 2 ) );
		translate( v = [( m8_nut_diameter / 2 ) + ( m3_nut_diameter / 2 ) + 2, 0, 5] ) rotate( a = [0, 0, 30] ) cylinder( h = 15, r = ( m3_nut_diameter / 2 ), $fn = 6 );
		rotate( a = [0, 0, 30] ) translate( v = [0, 0, 5] ) cylinder( h = 15, r = ( m8_nut_diameter / 2 ), $fn = 6 );

		translate( v = [( ( m8_diameter / 2 ) + 3 ) * 2 + ( m3_diameter / 2 ) + 2 + ( ( ( m3_diameter / 2 ) + 2 ) * 2 ) / 2 - 4, 0, 0] ) rotate( a = [0, 0, -25] ) difference()
		{
		 	translate( v = [0, 0, -1] ) cube(size = [10, 10, 20] );
		 	rotate( a = [0, 0, 50] ) translate( v = [0, 0, -1.5] ) cube( size = [30, 30, 21] );
		}
	
		translate( v = [( ( m8_diameter / 2 ) + 3 ) * 2 + ( m3_diameter / 2 ) + 2 + ( ( ( m3_diameter / 2 ) + 2 ) * 2 ) / 2 - 4, -3.7, 0] ) rotate( a = [0, 0, -25] ) difference()
		{
	 		translate( v = [0, 0, -1] ) cube( size = [10, 10, 20] );
		 	rotate( a = [0, 0, 50] ) translate( v = [0, 0, -1.5] ) cube( size = [30, 30, 21] );
		}
	
		translate( v = [( ( m8_diameter / 2 ) + 3 ) * 2 + ( m3_diameter / 2 ) + 2 + ( ( ( m3_diameter / 2 ) + 2 ) * 2 ) / 2 - 4, 3.7, 0] ) rotate( a = [0, 0, -25] ) difference()
		{
		 	translate( v = [0, 0, -1] ) cube( size = [10, 10, 20] );
		 	rotate( a = [0, 0, 50] ) translate( v = [0, 0, -1.5] ) cube( size = [30, 30, 21] );
		}
	}
}