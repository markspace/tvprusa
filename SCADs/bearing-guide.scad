// PRUSAMendel
// GNUGPLv2
// GregFrost

include <configuration.scad>

/**
 * Helps to hold belt aligned on the bearing.
 * @id bearing-guide
 * @name Bearing guide
 * @category Printed
 */

single_layer_width = filament_width;
bearing_inner = bearing_diameter + 0.6;
thickness = layer_height * 4.1;
height = bearing_thickness + thickness;
wall_ascent = 3;
wall_descent = 0.5;
tolerance = 0.15;
lip = 0.3;

inner();
translate([ bearing_diameter + 2 * wall_ascent + 2, 0, 0 ]) outer();

module inner() 
{
	difference()
	{
		cylinder( r = bearing_inner / 2 + single_layer_width, h = height );
		translate([ 0, 0, -1])
		cylinder( r = bearing_inner / 2, h = height + 2);
	}

	difference()
	{
		cylinder( r = bearing_inner / 2 + wall_ascent, h = thickness );
		translate([ 0, 0, -1])
		cylinder( r = bearing_inner / 2 - wall_descent, h = thickness + 2 );
	}
}

module outer()
{
	difference()
	{
		cylinder( r = bearing_inner / 2 + 2 * single_layer_width + lip + tolerance, h = height );
		translate([ 0, 0, -1 ])
		cylinder( r = bearing_inner / 2 + single_layer_width + lip + tolerance, h = height + 2 );
	}

	difference()
	{
		cylinder( r = bearing_inner / 2 + wall_ascent, h = thickness );
		translate([ 0, 0, -1 ])
		cylinder( r = bearing_inner / 2 - wall_descent, h = thickness + 2 );
	}
}