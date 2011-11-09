m3_nut_diameter= 7;
m3_diameter=4;

module hex_hole()
	{
	rotate([90,22.5,0]) cylinder(h = 8, r=m3_diameter/2, $fn=8); // M3 hole
	rotate([90,0,0]) translate ([0,0,5]) cylinder(h = 3, r=m3_nut_diameter/2, $fn=6); // M3 hex 
	}

module block()
	{
	difference()
		{
		union()
			{
			translate([0,10,12]) cube ([40,6,24], center=true);
			cylinder(24,r=12,$fn=100);
			}

		union()
			{
			translate([-1,-13,-1]) cube([2,14,26]); 
			translate([0,0,-1]) cylinder( 26, r=6, $fn=100);
			translate([0,0,-1]) cylinder( 26, r=7.55,$fn=100); // COMMENT OUT FOR END STOP
//			translate([0,0,2]) cylinder( 26, r=7.55, $fn=100); // UNCOMMENT FOR END STOP
			}
		}
	}

difference()
	{
	block();

	translate ([-15.5,14,5]) hex_hole();
	translate ([15.5,14,5]) hex_hole();
	translate ([-15.5,14,19]) hex_hole();
	translate ([15.5,14,19]) hex_hole();
	}