// PRUSA Mendel  
// Microswitch mount
// Used for mounting tiny microswitches with no lever
// GNU GPL v2
// Ian Stratford
// ginjaian@gmail.com

ms_x = 13; // exact size = 12.8
ms_y = 5.8; // exact size = 5.8
ms_z = 6.6; // exact size = 6.6
m8_diameter = 8.2;
m3_diameter = 3.5;
m3_nut_diameter = 6.8; // normally 6.2mm

module microswitch()
{
	difference()
	{
		union()
		{
		translate ([0,0,0]) cube ([ms_x+4,ms_y+4+1,ms_z+1]); // microswitch houseing
		translate( [((ms_x+4)/2)-((m8_diameter + 4)/2), -15.5, 0] ) cube( [m8_diameter + 4, 17, ms_z+1] ); // clamp
		translate( [ms_x/2-7, -11, (ms_z+1)/2] ) rotate( [0, 90, 0] ) rotate ([0,0,30]) cylinder( h = 3, r = (ms_z+2.2) / 2, $fn = 6 ); // captive nut
		}

	translate ([ms_x/2+2-6.5/2, ms_y+5.5, 3.5]) rotate ([90,22.5,0]) #cylinder (h=ms_y+5.5, r=1.1, $fn=8); // screw hole
	translate ([ms_x/2+2+6.5/2, ms_y+5.5, 3.5]) rotate ([90,22.5,0]) #cylinder (h=ms_y+5.5, r=1.1, $fn=8); // screw hole
	translate ([2,2.5,2]) cube ([ms_x,ms_y,ms_z]); // microswitch
	translate ([2,3.5,-.5]) cube ([ms_x,ms_y-2,ms_z+1]); // back slot
	translate ([2,2,2]) cube ([1.5,1.5,ms_z]); // removes extra from corners for easier fit
	translate ([ms_x+0.5,2,2]) cube ([1.5,1.5,ms_z]); // removes extra from corners for easier fit
	translate ([2,1.5+ms_y,2]) cube ([5,1.5,ms_z]); // removes extra from corners for easier fit
	translate ([ms_x-3,1.5+ms_y,2]) cube ([5,1.5,ms_z]); // removes extra from corners for easier fit


	translate( [((ms_x+4)/2), -m8_diameter/2, -0.5] ) cylinder( h = ms_z+2, r = m8_diameter/2, $fn = 18 ); // M8 rod hole
	translate( [((ms_x+4)/2), -m8_diameter/2-5, (ms_z+1)/2] ) cube( [5, 14, ms_z+2], center = true ); // clamp split
	translate( [0, -11, (ms_z+1)/2] ) rotate( [0, 90, 0] ) rotate ([0,0,22.5]) cylinder( h = ms_x+4, r = m3_diameter / 2, $fn = 8 ); // clamp bolt hole
	translate( [ms_x/2-7.5, -11, (ms_z+1)/2] ) rotate( [0, 90, 0] ) rotate ([0,0,30]) cylinder( h = 2.4, r = m3_nut_diameter/2 , $fn = 6 ); // captive nut cut out


	}
}


translate ([-ms_x/2-2,0,0]) microswitch();


