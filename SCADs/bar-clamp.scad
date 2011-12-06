// PRUSA Mendel  
// Bar clamp
// Used for joining 8mm rods
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>

/**
 * @id bar-clamp
 * @name Bar clamp
 * @category Printed
 * @using 2 m8nut
 * @using 2 m8washer
 */ 

barclamp();

module barclamp()
{
	outer_diameter = m8_diameter / 2 + 3.3;

	difference()
	{
		union()
		{
		
			translate( [outer_diameter, outer_diameter, 0] ) cylinder( h = outer_diameter * 2, r = outer_diameter, $fn = 20);
			translate( [outer_diameter, 0, 0] ) cube( [outer_diameter + 1.5, outer_diameter * 2, outer_diameter * 2] );
			translate( [18, 2 * outer_diameter, outer_diameter] ) rotate( [90, 0, 0] ) nut( outer_diameter * 2, outer_diameter * 2, false);
		}

		translate( [18, outer_diameter, 9] ) cube( [18, 5, 20], center = true );
		translate( [outer_diameter, outer_diameter, -1] ) #polyhole( m8_diameter, 20 );
		translate( [17, 17, 7.5] ) rotate( [90, 0, 0] ) #polyhole( m8_diameter, 20 );
	}
}


