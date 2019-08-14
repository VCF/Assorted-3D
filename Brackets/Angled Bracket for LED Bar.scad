// Angled Bracket for LED Bar
// Charles Tilford, 2019
// License: CC BY-NC-SA 4.0
//   https://creativecommons.org/licenses/by-nc-sa/4.0/

// Units in mm

length=20;  // Length of bar (mostly)
width=25;   // Actual width of bar
angle=45;   // How much we want the bar tilted
clipWid=2;  // How thick the clips should be
// Width of supporting surface including space for clips:
clpWid=width+2*clipWid;
clipHigh=2.5; // How high clips are
tuck=15;       // How much the clips should 'tuck in'
adj=sin(angle) * clpWid; // Adjacent (base) edge
opp=cos(angle) * clpWid; // Opposite (elevated) edge
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
// Make sure we have a base even on the 'thin' side:
translate([0,0,0])
linear_extrude(height=bump)
square(size=[length, adj]);
// Make the slanted frame
translate([0,0,bump])
linear_extrude(height=opp, scale=[1,0])
square(size=[length, adj]);
}
difference() {
  // The cone for the screw head:
  translate([length/2,clipWid + adj/2, 2])
    color("red")
    cylinder(h=opp-bump, d2=adj*1.2,
             d1=0, $fn=40);
    // Clip the back of the cone to support top more:
    translate([0,0,0])
    linear_extrude(height=opp+bump)
    square(size=[length, adj/3]);
}
  // The cylindrical hole for the screw body:
  translate([length/2,clipWid +adj/2,holeFloor])
    cylinder(h=opp, d=screwWid, $fn=30);
}

// Top clip
translate([0,0,opp+bump])
rotate(a=[0-(angle+tuck),0,0])
linear_extrude(height=clipHigh)
square(size=[length, clipWid]);

// Bottom clip
translate([0,adj-clipWid,bump])
rotate(a=[0-(angle-tuck),0,0], v=[0,adj*2,bump])
color("blue")
linear_extrude(height=clipHigh+sin(angle-tuck)*clipWid)
square(size=[length, clipWid]);

// Colors are just to aid visualization of
// void spaces. $fn is "featuer number", ie how
// many polygons are devoted to object. The values
// above should be near your printing limit anyway.

// Developed in OpenSCAD
//    https://www.openscad.org/