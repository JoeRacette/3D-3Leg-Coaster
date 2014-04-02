//  Create a coaster that is 3D printable and will stack
// January 2014 - JWR
// 
// define parameters
// mm units
outside_diam = 90;
height = 10;
lip = 6;
rim = 10;
thick = 2;
//
difference () 
{ union()
{
cylinder(h = height - lip, r1 = (outside_diam / 2) - rim, r2 = (outside_diam / 2), center = false);
translate([0,0,height - lip])
cylinder(h = lip, r = (outside_diam / 2), center = false);
}
// inside
union()
{
translate([0,0,height-thick])
cylinder(h = thick, r1 = (outside_diam / 2) - rim, r2 = (outside_diam / 2) - rim + thick, center = false);
translate([0,0,thick])
cylinder(h = height- thick, r = (outside_diam / 2) - rim, center = false);
}}