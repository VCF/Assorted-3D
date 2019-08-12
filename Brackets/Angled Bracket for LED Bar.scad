// Angled Bracket for LED Bar
// Charles Tilford, 2019
// License: CC BY-NC-SA 4.0
//   https://creativecommons.org/licenses/by-nc-sa/4.0/

length=20;  // Length of bar (mostly)
width=25;   // Actual width of bar
angle=45;   // How much we want the bar tilted
adj=sin(angle) * width; // Adjacent edge
opp=cos(angle) * width; // Opposite edge
bump=3;                 // Extra height

// Screw dimensions. Default presumes
// #6 sheet metal screw
screwWid=3.6; // Width of screw shaft
screwTop=6.78;// Width of screw head
screwCon=5.08;// Height of head 'cone'

// Thin floor below holes. My printer was
// struggling to have the hole 'border' stick
// to the stage. Just drill/screw thru it.
holeFloor=0.15; 

difference() {
union() {
// Make sure we have a base even on 'thin' side:
translate([0,0,0])
linear_extrude(height=bump)
square(size=[length, adj]);
// Make the slanted frame
translate([0,0,bump])
linear_extrude(height=opp, scale=[1,0])
square(size=[length, adj]);
}
  translate([length/2,adj/2, adj/2-bump*2]) color("red")
    cylinder(h=screwCon*3, d2=screwTop*3,
             d1=0, $fn=20);
  translate([length/2,adj/2,holeFloor])
    cylinder(h=opp, d=screwWid, $fn=20);
}



// Colors are just to aid visualization of
// void spaces. $fn is "featuer number", ie how
// many polygons are devoted to object. The values
// above should be near your printing limit anyway.

// Developed in OpenSCAD
//    https://www.openscad.org/