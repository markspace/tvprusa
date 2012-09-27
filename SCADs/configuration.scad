// PRUSA Mendel  
// Configuration file
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

// PLEASE SELECT ONE OF THE CONFIGURATIONS BELOW
// BY UN-COMMENTING IT

// Uncomment for metric settings
// METRIC METRIC METRIC METRIC METRIC METRIC METRIC METRIC 

include <metric.scad>;

// Uncomment for imperial settings
// IMPERIAL IMPERIAL IMPERIAL IMPERIAL IMPERIAL IMPERIAL IMPERIAL 

//include <sae.scad>;

// CUSTOM CUSTOM CUSTOM CUSTOM CUSTOM CUSTOM CUSTOM CUSTOM CUSTOM

// Thin walls
layer_height = 0.3;
wot = 1.5;
filament_width = layer_height * wot;

thin_wall = 4 * layer_height * wot;

// LM8UU
linear = true;
linear_bearing_diameter = 15;
linear_bearing_length = 24;

//608 bearing
bearing_diameter = 22;
bearing_thickness = 7;

//Timing belt
belt_pitch = 5;

// CHANGE ONLY THE STUFF YOU KNOW
// IT WILL REPLACE DEFAULT SETTING

// RODS

// threaded_rod_diameter = 0;
// threaded_rod_diameter_horizontal = 0;
// smooth_bar_díameter = 0;
// smooth_bar_díameter_horizontal = 0;

// Nuts and bolts

m8_diameter = 8.4;
m8_nut_diameter = 15.4;
m8_nut_thickness = 6.3;;

// m4_diameter = 0;
 m4_nut_diameter = 8.5;
// m4_nut_thickness = 0;

m3_diameter = 3.6;
//m3_nut_diameter = 7 should be flats measurement;
m3_nut_diameter = 6.1;
m3_nut_thickness = 3;

// Bushing holder

// bushing_core_diameter = smooth_bar_díameter;
// bushing_material_thickness = 0;

///counted stuff
m3_nut_diameter_bigger = ( ( m3_nut_diameter  / 2) / cos( 180 / 6 ) ) * 2;

// functions 
include <functions.scad>
