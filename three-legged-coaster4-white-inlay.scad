//  Create a coaster that is 3D printable 
//  maybe stack
//  v2 add the logo
//  v3 make paintable
//  v4 colored pieces - this is the white piece
// Jan 2014 - Feb 2014
// - JWR
// 



// define parameters
// mm units
$fa = 1;  // degrees for each face
outside_diam = 90;
fit = 0.4;  // amount of clearence between colors
height = 7;
rim = 10;
thick = 2; // thickness of base
logo_height = 2;
logo_width = 5;
chamfer = 0.75;
//

// channel on top of rim
difference()
{

cylinder(h = logo_height - fit, r = (outside_diam / 2) - (chamfer * 2) - fit, center = false);

cylinder(h = logo_height - fit, r = (outside_diam /2) - rim + (chamfer*2) + fit, center = false);
} // end of difference for top channel



