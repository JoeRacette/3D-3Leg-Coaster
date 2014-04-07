//  Create a coaster caddy that is 3D printable 
//  
// Jan 2014 - Feb 2014
// - JWR
// 
// v4 match color inlay design
//  - Make body 1mm shorter


module base(coaster_diam, diam, height, thick, chamfer, rim, logo_height)
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

// subtract the inside
union() // of inside chamfer, channel on top of rim, and interior
{
// inside chamfer
// translate([0,0,height - chamfer])
// cylinder(h = chamfer, r1 = (diam / 2) - rim, r2 = (diam / 2) - rim + chamfer, cente// r = false);

// interior space
translate([0,0,thick])
cylinder(h = height- thick, r = (coaster_diam / 2) - rim, center = false);

// channel on top of rim
difference()
{
translate([0,0,(height- logo_height)])
cylinder(h = logo_height, r = (coaster_diam / 2) - (chamfer*2), center = false);
translate([0,0,(height - logo_height)])
cylinder(h = logo_height, r = (coaster_diam /2) - rim + (chamfer*2), center = false);
} // end of difference for top channel
} // end union inside// interior space


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
height = 8;          // coaster/base height
wall_height = coasters * height;
total_diam = outside_diam + (outside_walls * 2) + 2; // add clearance
rim = 10;            // coaster rim
thick = 2; // thickness of base
logo_height = 2.0;
logo_width = 5;
chamfer = 0.75;
// base_height = height;
base_height = thick + logo_height;



 	// draw each limb part

limb(-27,-12,-13,-0.5, logo_width,logo_height,thick);
limb( -11,0,9,0, logo_width, logo_height, thick);
limb( -4,-12,23,14, logo_width,logo_height,thick);
limb(8,-0.5,21,-12, logo_width,logo_height,thick);
limb(22,11,27,11, logo_width,logo_height,thick);

// draw the base 
base(outside_diam, total_diam, base_height, thick, chamfer, rim, logo_height);

difference ()
{
intersection ()
{ 
// use this cylinder to define the top curve
translate ([0, total_diam/2, 0])
rotate ( a = [90, 0, 0])
cylinder(h = total_diam, r = wall_height + base_height, center = false);

difference ()
{ // define the vertical cylinder
translate([0,0,base_height])
cylinder(h = wall_height, r = (total_diam / 2), center = false);
translate([0,0,base_height])
cylinder(h = wall_height, r = (total_diam / 2) - outside_walls, center = false);
} // end difference vertical cylinder
} // end intersection

// subtract the area crosswise, down to th original base
translate ([-total_diam/2, 0, wall_height])
rotate ( a = [0, 90, 0])
cylinder(h = total_diam, r = (outside_diam-outside_walls)/2, center = false);

} // difference
