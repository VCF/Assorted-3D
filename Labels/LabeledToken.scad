// Numbered tokens for 3D printing
// Charles Tilford, 2019
// License: CC BY-NC-SA 4.0
//   https://creativecommons.org/licenses/by-nc-sa/4.0/


/* These were designed as more robust (than plastic tape)
   outdoor markers to label survey stakes. The build has
   a rectangular "token" with "loops" at the upper left
   and right corners to allow a string to be tied to them.
   A text "label" is specified that will be on each
   token, as well as a number that will be iterated for
   different tokens.
*/

label="Wetlands";     // The common label on each token
number="15";           // The number of this token

// Units are in mm

// Token dimensions
depth=6;   // Thickness of rectangle
width=50;  // Width
// Height is calculated from sum of other dimensions

// Control over the loop dimensions
loopThick=4; // Thickness (half circle)
loopWidth=6; // Width
loopHole=3;  // Diameter of hole through loop

// Label font
lName="FreeSans:style=Bold";
lSize=7; // font size
lDepth=1; // Raised height of font

// Number font
nName="Open Sans:style=Bold";
nSize=14;
nDepth=2;
// https://fonts.google.com/specimen/Open+Sans
// Designer: Steve Matteson

txtSpc=2; // Distance between text lines and other objs

padding=1; // Extra padding when cutting out bits


// ==========================================
// ===== All values below are auto-calculated
// ==========================================

loopDia=loopThick*2;
height=loopDia+lSize+nSize+3*txtSpc;

difference() {
  // We use difference() to punch out the holes
  // in the character
  union() {
    // The token backing
    translate([-width/2,-height/2,0])
      cube(size=[width,height,depth]);
      
    // The loop body, a cylinder across the top
    translate([-width/2,height/2 - loopThick,depth])
    rotate(a=[0,90,0])
      cylinder(r=loopThick, h=width, $fn=40);
  }
  // Slice the middle out of the loop, leave two bits
  translate([loopWidth-width/2,height/2-loopDia,depth])
      cube(size=[width-(loopWidth*2),loopDia,loopThick],
           color="red");
  // The hole through the loop
  translate([-width/2-padding,height/2 - loopThick,depth])
  rotate(a=[0,90,0])
    cylinder(d=loopHole, h=width+padding*2, $fn=40,
             color="red");
}


// The label text
translate([0,height/2-loopDia-txtSpc,depth])
  linear_extrude(height=lDepth, scale=1)
  text(label, size=lSize, halign="center", valign="top",
       $fn=100, font=lName);

// The number text
translate([0,height/2-loopDia-lSize-2*txtSpc,depth])
  linear_extrude(height=nDepth, scale=1)
  text(number, size=nSize, halign="center", valign="top",
       $fn=100, font=nName);

// Colors are just to aid visualization of
// void spaces. $fn is "featuer number", ie how
// many polygons are devoted to object. The values
// above should be near your printing limit anyway.

// Developed in OpenSCAD
//    https://www.openscad.org/