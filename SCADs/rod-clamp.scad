// PRUSA Mendel  
// Rod clamp
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel


include <configuration.scad>

/**
 * @id rod-clamp
 * @name Rod clamp
 * @category Printed
 */

rodclamp();
%cube([200,200,0.01],center=true);

module rodclamp()
{ 
	 translate ([-5,0,12]) rotate ([0,90,0]) difference()
	{
		union ()
		{ 
		translate ([0,-7,0]) cube( [9, 14, 10] );
		translate ([0.01, 7, 5]) rotate ([0,90,0]) cylinder( r = 9.99 / 2, h = 12 );
		translate ([0.01, -7, 5]) rotate ([0,90,0]) cylinder( r = 9.99 / 2, h = 12 );
		}
	
		translate ([-.4, 0, -1]) rotate ([0,0,22.5]) #cylinder( r = 4, h = 12, $fn=8 );
//		translate ([12, 0, -1]) rotate ([0,0,22.5]) #cylinder( r = 4, h = 12, $fn=8 );
		translate ([-1, 7, 5]) rotate ([0,90,0]) #polyhole( m3_diameter,14 );
		translate ([-1, -7, 5]) rotate ([0,90,0]) #polyhole( m3_diameter,14 );
	}
}




