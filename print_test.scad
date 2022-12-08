include <extrude_test2.scad>
include <rails.scad>
include <print_cube.scad>

/*
difference() {
    //translate([0,0,-0.9]) rotate(atan(sqrt(2)), v=[1,-1,0]) //cube_bottom();
    
    translate([0,0,1.3]) rotate([180,0,0]) rotate(atan(sqrt(2)), v=[1,-1,0])
    cube_top();
    translate([0,0,-1]) cube([2,2,2], center=true);
}
*/

translate([0,0,sqrt(3)]) rotate(180+atan(sqrt(2)), v=[1,-1,0]) {
    difference() {
        cube();
        translate([wall_thickness,wall_thickness,wall_thickness]) cube([1,1,1]*(1-2*wall_thickness));
        rotate(-atan(sqrt(2)), v=[1,-1,0]) translate([0,0,2.075-2]) cube([2,2,2], center=true);
    }
    translate([0,0,1]) rail_A_positioned();
    translate([0,0,1]) rail_C_positioned();
}