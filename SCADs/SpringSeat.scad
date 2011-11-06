/*
    Author: Andy Kirby, Email: andy@kirbyand.co.uk, Date: 27/12/2010
    Contributors: 
    Licensing GPL V3 (http://www.gnu.org/licenses/quick-guide-gplv3.html).

    Script to create a Spring Seat used to centre and retain springs on a rod or bolt.
*/

/* Global Variables */
// Parameters to change the parts vital dimensions
seath = 4;                // overall height of spring seat (mm)
holeid = 4;               // Inside Diameter of centre hole (mm)
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
               cylinder(h=sectionh, r1=springor, r2=springor, center=false, $fn=smoothness);
            // retainer section
               translate(v = [0, 0, sectionh] ) cylinder(h=sectionh, r1=springir, r2=springir, center=false, $fn=smoothness);
         }
         // subtract the hole 
           cylinder(h=seath, r1=holer, r2=holer, center=false, $fn=smoothness);
   }
}
