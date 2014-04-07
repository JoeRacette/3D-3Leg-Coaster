//  Create a coaster that is 3D printable 
//  maybe stack
//  v2 add the logo
// January 2014 - JWR
// 


module coaster(diam, height, thick, chamfer)
{
 difference () 
{ 
// Define the cylinder with top and bottom
// outside chamfers
union()
{
// bottom outside chamfer
cylinder(h = chamfer, r1 = (diam / 2) - chamfer, r2 = (diam / 2), center = false);
// top outside chamfer
translate([0,0,height - chamfer])
cylinder(h = chamfer, r1 = (diam / 2), r2 = (outside_diam / 2) - chamfer, center = false);
// middle of cylinder
translate([0,0,chamfer])
cylinder(h = height - chamfer - chamfer, r = (diam / 2), center = false);
} // end union outside
// subtract the inside
union()
{
// inside chamfer
translate([0,0,height - chamfer])
cylinder(h = chamfer, r1 = (diam / 2) - rim, r2 = (diam / 2) - rim + chamfer, center = false);

// interior space
translate([0,0,thick])
cylinder(h = height- thick, r = (diam / 2) - rim, center = false);
} // end union inside
} // end difference outside - inside
} // end coaster module 

module limb(startx, starty, endx, endy, width, elev, z)
{
translate([startx, starty, z])
rotate( a = [0, 0, atan((endy - starty)/(endx - startx))])
translate([-width/2, -width/2, 0])
cube([pow(pow(endx - startx,2)+pow(endy - starty ,2),0.5) + width , width, elev], center=false);

} // end limb module


// define parameters
// mm units
outside_diam = 90;
height = 7;
rim = 10;
thick = 2; // thickness of base
logo_height = 0.33;
logo_width = 5;
chamfer = 1;
//



 	// draw each part
limb(-28,-12,-14,-0.5, logo_width,logo_height,thick);
limb( -12,0,9,0, logo_width, logo_height, thick);
limb( -4,-12,23,14, logo_width,logo_height,thick);
limb(8,-0.5,21,-12, logo_width,logo_height,thick);
limb(22,11,27,11, logo_width,logo_height,thick);

coaster(outside_diam, height, thick, chamfer);



