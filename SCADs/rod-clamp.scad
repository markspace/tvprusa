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
//%cube([200,200,0.01],center=true);

module rodclamp()
{ 
	difference ()
	{
		hull ()
		{ 
		translate ([7, 0, 0]) rotate ([0,0,0]) cylinder( r = 10 / 2, h = 12 );
		translate ([-7, 0, 0]) rotate ([0,0,0]) cylinder( r = 10 / 2, h = 12 );
		}
	
		translate ([0, 0, 12.1]) rotate ([90,11.25,0]) #cylinder( r = 4, h = 12, center = true, $fn=16 );
		translate ([0, 0, -.1]) rotate ([90,22.5,0]) #cylinder( r = 4, h = 12, center = true, $fn=8 );
		translate ([7, 0, -1]) polyhole( m3_diameter,14 );
		translate ([-7, 0, -1]) polyhole( m3_diameter,14 );
	}
}




