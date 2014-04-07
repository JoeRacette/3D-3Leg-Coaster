//  Create a coaster that is 3D printable 
//  maybe stack
//  v2 add the logo
//  v3 make paintable
//  v4 colored pieces - this is the yellow one
//       - mirror image to take advantage of the bed surface
//       - shorten body by 1 mm to fit better
// Jan 2014 - Feb 2014
// - JWR
// 


module limb(startx, starty, endx, endy, width, elev, z)
{
translate([startx, starty, z])
rotate( a = [0, 0, atan((endy - starty)/(endx - startx))])
translate([-width/2, -width/2, 0])
cube([pow(pow(endx - startx,2)+pow(endy - starty ,2),0.5) + width , width, elev], center=false);

} // end limb module


// define parameters
// mm units
$fa = 1;  // degrees for each face
fit = 0.4;  // clearence between colors
outside_diam = 90;
height = 7;
rim = 10;
thick = 0; // offset of base
logo_height = 2;
logo_width = 5;
chamfer = 0.75;
//

 difference () // between the basic cylinder and the inside area
{ 
cylinder(h = logo_height - fit, r = (outside_diam / 2) - rim - (2*fit), center = false);
union() // of inside chamfer, channel on top of rim, and interior
{
 	// draw each part
// limb(-28,-12,-15,-1, logo_width+(fit*2),logo_height - fit,thick,0); // hind leg
// limb( -12,0,9,0, logo_width+(fit*2), logo_height - fit, thick,0);  // body
// limb( -4,-12,23,14, logo_width+(fit*2),logo_height - fit,thick,0);  // front leg-neck
// limb(8,-0.5,21,-12, logo_width+(fit*2),logo_height - fit,thick,0);  // foremost leg
// limb(22,11,27,11, logo_width+(fit*2),logo_height - fit,thick,0);   // snout

limb(14,-1,27,-12, logo_width+(fit*2),logo_height - fit,thick,0); // hind leg
limb( -9,0,11,0, logo_width+(fit*2), logo_height - fit, thick,0);  // body
limb( -23,14,4,-12, logo_width+(fit*2),logo_height - fit,thick,0);  // front leg-neck
limb( -21,-12,-8,-0.5, logo_width+(fit*2),logo_height - fit,thick,0);  // foremost leg
limb(-27,11,-22,11, logo_width+(fit*2),logo_height - fit,thick,0);   // snout

}  // end union of all limbs
} // end subtract limbs



