//  Create a coaster caddy that is 3D printable 
//  
// Jan 2014 - Feb 2014
// - JWR
// 


module base(diam, height, thick, chamfer, rim, logo_height)
{
 difference () // between the basic cylinder and the inside area
{ 
// Define the cylinder with bottom
// outside chamfer
union() // of outside top and bottom chamfers and main cylinder
{
// bottom outside chamfer
cylinder(h = chamfer, r1 = (diam / 2) - chamfer, r2 = (diam / 2), center = false);

// middle of cylinder
translate([0,0,chamfer])
cylinder(h = height - chamfer, r = (diam / 2), center = false);
} // end union outside

// interior space
translate([0,0,thick])
cylinder(h = height- thick, r = (diam / 2) - rim, center = false);

} // end difference outside - inside
} // end base module 

module limb(startx, starty, endx, endy, width, elev, z)
{
translate([startx, starty, z])
rotate( a = [0, 0, atan((endy - starty)/(endx - startx))])
translate([-width/2, -width/2, 0])
cube([pow(pow(endx - startx,2)+pow(endy - starty ,2),0.5) + width , width, elev], center=false);

} // end limb module


// define parameters
// mm units
coasters = 7;        // caddy will hold this many coasters
$fa = 1;             // degrees for each face
outside_diam = 90;   // coaster diam
outside_walls = 3;   // wall thickness
height = 7;          // coaster/base height
wall_height = coasters * height;
total_diam = outside_diam + (outside_walls * 2) + 2; // add clearance
rim = 10;            // coaster rim
thick = 2; // thickness of base
logo_height = 0.5;
logo_width = 5;
chamfer = 0.75;
base_height = height;
// base_height = thick + chamfer + logo_height;



 	// draw each part
limb(-28,-12,-14,-0.5, logo_width,logo_height,thick);
limb( -12,0,9,0, logo_width, logo_height, thick);
limb( -4,-12,23,14, logo_width,logo_height,thick);
limb(8,-0.5,21,-12, logo_width,logo_height,thick);
limb(22,11,27,11, logo_width,logo_height,thick);

base(total_diam, base_height, thick, chamfer, rim + (total_diam - outside_diam)/2, logo_height);

difference ()
{
intersection ()
{
translate ([0, total_diam/2, 0])
rotate ( a = [90, 0, 0])
cylinder(h = total_diam, r = wall_height + base_height, center = false);

difference ()
{
translate([0,0,base_height])
cylinder(h = wall_height, r = (total_diam / 2), center = false);
translate([0,0,base_height])
cylinder(h = wall_height, r = (total_diam / 2) - outside_walls, center = false);
} // end difference vertical cylinder
} // end intersection

translate ([-total_diam/2, 0, wall_height])
rotate ( a = [0, 90, 0])
cylinder(h = total_diam, r = (outside_diam-outside_walls)/2, center = false);

} // difference
