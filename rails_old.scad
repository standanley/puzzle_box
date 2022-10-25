include <extrude_test2.scad>

w = 0.03;
d = 0.1;
eps = 0.01;

//cube();

//cut_cube();


module top() {
    translate([0,0,1])
    rotate([1,0,0]*45)
    translate([.5, 0, 0])
    cube([1+2*eps, w, d*2], center=true);
}

module top_complete() {
    
    top();
    mirror([1,-1,0]) top();
    translate([1,0,0]) rotate(90) top();
    translate([0,1,0]) mirror([1,-1,0]) rotate(90) top();
}

difference() {

    //cube([1,1,1]);
    cut_cube();
    top_complete();
    translate([0,0,1]) mirror([0,0,1]) top_complete();
}

