// PRUSA Mendel  
// Microswitch mount
// Used for mounting tiny microswitches with no lever
// GNU GPL v2
// Ian Stratford
// ginjaian@gmail.com

thin_wall = 0.43;
wall = thin_wall*6;
2wall = wall*2;

ms_x = 13.2; // exact size = 12.8
ms_y = 6.05; // exact size = 5.75
ms_z = 6.6; // exact size = 6.6
m8_diameter = 8.2;
m3_diameter = 3.6;
m3_nut_diameter = 7.0;
bz=1.5;

module microswitch()
{
	difference()
	{
		union()
		{
		translate ([0,0,0]) cube ([ms_x+2wall,ms_y+2wall+1,ms_z+bz]); // microswitch houseing
		translate( [((ms_x+(2wall*2))/2)-((m8_diameter + (2wall*2))/2), -15.5, 0] ) cube( [m8_diameter + 2wall, 17, ms_z+bz] ); // clamp
		translate( [ms_x/2-7, -10.5, (ms_z+bz)/2] ) rotate( [0, 90, 0] ) rotate ([0,0,30]) cylinder( h = 3, r = ((ms_z+bz)/cos(180/6)) / 2, $fn = 6 ); // captive nut
		}


		translate ([wall,wall+0.5,0]) 
		{
			translate ([0,0,bz+1])cube ([ms_x,ms_y,ms_z]); // microswitch
			translate ([0,1,-.5]) cube ([ms_x,ms_y-2,ms_z+bz]); // back slot
		
			translate ([0,-0.5,bz+1]) cube ([1.5,1.5,ms_z]); // removes extra from corners for easier fit
			translate ([ms_x-1.5,-0.5,bz+1]) cube ([1.5,1.5,ms_z]); // removes extra from corners for easier fit
			translate ([0,ms_y-1,bz+1]) cube ([5,1.5,ms_z]); // removes extra from corners for easier fit
			translate ([ms_x-5,ms_y-1,bz+1]) cube ([5,1.5,ms_z]); // removes extra from corners for easier fit
		
		}

		translate( [((ms_x+2wall)/2), -m8_diameter/2, -0.5] ) cylinder( h = ms_z+bz+1, r = m8_diameter/2, $fn = 18 ); // M8 rod hole
		translate( [((ms_x+2wall)/2), -m8_diameter/2-7, (ms_z+bz)/2] ) cube( [7.5, 14, ms_z+bz+1], center = true ); // clamp split
		translate( [0, -10.5, (ms_z+bz)/2] ) rotate( [0, 90, 0] ) rotate ([0,0,360/24]) cylinder( h = ms_x+4, r = m3_diameter / 2, $fn = 12 ); // clamp bolt hole
		translate( [ms_x/2-7.5, -10.5, (ms_z+bz)/2] ) rotate( [0, 90, 0] ) rotate ([0,0,30]) cylinder( h = 2.4, r = m3_nut_diameter/2 , $fn = 6 ); // captive nut cut out

	}
}

translate ([-ms_x/2-wall,0,0]) microswitch();
