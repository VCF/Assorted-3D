/* Simple Bushings for 3D printing
   Charles Tilford, 2019
   License: CC BY-NC-SA 4.0
   https://creativecommons.org/licenses/by-nc-sa/4.0/
*/

/*
  A cylindrical bushing / spacer. Basically a cylinder
  with a cylindrical hole through the middle.

  The idea here is to define a set of bushings with a
  fixed RATIO between the inner diameter of the hole
  and the outer diameter of the cylinder as a whole.
  You can then define specic sizes (total width and
  height) by scaling in your slicing program.

  OI ratio of 1 = 100% hole (no object)
  Squat + high OI ratio = washer
  Tall + low ratio = pipe.
*/

/* The ratio below is really the the thickness of the
   outer wall and the inner diameter. So a value of 2
   means that the outer wall is twice as thick as the
   diameter of the inner hole, for a total width of
   5 (2+1+2) and a total radius of 2.5
*/
OIratio=2;

height=5;  // Height of cylinder, arbitrary units
ID=5;      // Inner diameter
FN=60;     // Number of features for cylinder.
           //   more = smoother

/* Thin floor below holes. My printer was
   struggling to have the hole 'border' stick
   to the stage for some prints.Just drill/screw thru it.
   Set to zero for no floor.
*/
holeFloor=0; 

// ==========================================
// ===== All values below are auto-calculated
// ==========================================

OD=ID * OIratio; // Outer diameter
echo(str("Cylinder ID=",ID,", OD=",OD,", H=",height));

difference() {
  // We use difference() to punch out the inner hole
    
  // The overall cylinder
  translate([0,0,0])
    cylinder(d=OD, h=height, center=true, $fn=FN);
    
  // The hole in the middle
  translate([0,0,holeFloor]) color("red")
    cylinder(d=ID, h=height + 0.2, center=true, $fn=FN);
}

// Colors are just to aid visualization of
// void spaces.

// Developed in OpenSCAD
//    https://www.openscad.org/