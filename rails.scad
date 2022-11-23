include <extrude_test2.scad>
include <mazes.scad>

h = 0.06;
w = 0.05;
d = 0.025;
inset = 0.025;
eps = 0.01;
difference_gap = 0.003;

//cube();

//cut_cube();



//cube([1,1,1]);

module rail(length, gap=0) {
    // gap makes the rail bigger, for use with difference
    // eps is (I think) just some invisible overlap to union the pieces
    translate([0,inset-gap,-eps]) cube([length, d+2*gap, h+eps+gap]);
    translate([0, inset-gap, h-d-gap]) cube([length, w+2*gap, d+2*gap]);
}


module sled_with_rails(maze1) {
    difference() {
        //color([0.5, 0, 0])
        sled(maze1);
        rail(0.95, .003);

        translate([-.5, 0, 0])
        translate([0,.5,0])
        mirror([0,1,0])
        translate([0,-.5,0])
        rail(2, difference_gap);
    }
}


module positioned_rails() {
    break_position = 0.9;
    rail(break_position);
    translate([break_position+0.01, 0, 0])
    rail(1-break_position-0.01);
    
    translate([0.15, 0, 0])
    translate([0,.5,0])
    mirror([0,1,0])
    translate([0,-.5,0])
    rail(0.76);
}

//translate([(2*wall_radius + spacing/2), 0, 0])
//sled_with_rails(maze_a);
//positioned_rails();

//translate([.07,0,0]) cube([.1,.1,.03]);
//translate([0,0,.125]) rotate(-atan(sqrt(2)), v=[1,-1,0]) rail(0.15);
