include <extrude_test2.scad>
include <mazes.scad>

h = 0.06;
w = 0.05;
d = 0.025;
inset = 0.025;
eps = 0.01;

//cube();

//cut_cube();



//cube([1,1,1]);

module rail(length, gap=0) {
    // gap makes the rail bigger, for use with difference
    translate([0,inset-gap,-eps]) cube([length, d+2*gap, h+eps+gap]);
    translate([0, inset-gap, h-d-gap]) cube([length, w+2*gap, d+2*gap]);
}


module sled_with_rails(maze1) {
difference() {
color([0.5, 0, 0]) sled(maze1);
rail(0.95, .003);

translate([-.5, 0, 0])
translate([0,.5,0])
mirror([0,1,0])
translate([0,-.5,0])
rail(2, .003);
}
}

//sled_with_rails(maze_a);


translate([.07,0,0]) cube([.1,.1,.03]);
translate([0,0,.125]) rotate(-atan(sqrt(2)), v=[1,-1,0]) rail(0.15);
