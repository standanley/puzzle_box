include <extrude_test2.scad>

difference() {
    //translate([0,0,-0.9]) rotate(atan(sqrt(2)), v=[1,-1,0]) //cube_bottom();
    
    translate([0,0,1.3]) rotate([180,0,0]) rotate(atan(sqrt(2)), v=[1,-1,0])
    cube_top();
    translate([0,0,-1]) cube([2,2,2], center=true);
}