/*
    Author: Andy Kirby, Email: andy@kirbyand.co.uk, Date: 27/12/2010
    Contributors: 
    Licensing GPL V3 (http://www.gnu.org/licenses/quick-guide-gplv3.html).

    Script to create a Spring Seat used to centre and retain springs on a rod or bolt.
*/

include <configuration.scad>

/* Global Variables */
// Parameters to change the parts vital dimensions
seath = 4;                // overall height of spring seat (mm)
holeid = m3_diameter;               // Inside Diameter of centre hole (mm)
springid = 8;            // Inside Diameter of spring (mm)
springod = 10;	     // Outside Diameter of spring
smoothness = 32;  // Number of facets making up the circles in the piece


// Do not change precalculated factors.
sectionh = seath / 2;
holer = holeid / 2;
springir = (springid / 2) - 0.5; // 0.25mm clearence for spring to fit over retainer
springor = springod / 2;


/* Main or start function basicaly do it */
render (convexity = 1) {
   springseat();
}

/* The part description */
module springseat() {
   difference() {
     // from the spring seat solid
        union(){
            // base washer
               cylinder(h=sectionh, r=springor, center=false, $fn=smoothness);
            // retainer section
               cylinder(h=sectionh*2, r=springir, center=false, $fn=smoothness);
         }
         // subtract the hole 
          # translate ([0,0,-1]) cylinder(h=seath+2, r=holer, center=false, $fn=smoothness);
   }
}
