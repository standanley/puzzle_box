include <extrude_test2.scad>
include <mazes.scad>

h = 0.06;
w = 0.05;
d = 0.025;
inset = 0.025;
eps = 0.01;
difference_gap = 0.003;
break_position = 0.9;
break_gap = 0.001;
// With v1 I discovered that the rails don't slide nicely
// rather than reprint the mazes, I decided to shrink the rails
rail_gap_v2 = -0.002;

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


module positioned_rails_old() {
    rail_B();
    translate([break_position+break_gap, 0, 0])
    rail_C();
    
    translate([0.15, 0, 0])
    translate([0,.5,0])
    mirror([0,1,0])
    translate([0,-.5,0])
    rail_A();
}

module positioned_rails() {
    rail_A_positioned();
    rail_B_positioned();
    rail_C_positioned();
}

module rail_A() {
    rail(0.76, rail_gap_v2);
}

module rail_B() {
    rail(break_position, rail_gap_v2);
}
module rail_C() {
    rail(0.97-break_position-break_gap, rail_gap_v2);
}

module rail_A_positioned() {
    translate([0.15, 0, 0])
    translate([0,.5,0])
    mirror([0,1,0])
    translate([0,-.5,0])
    rail_A();
}

module rail_B_positioned() {
    rail_B();
}
module rail_C_positioned() {
    translate([break_position+break_gap, 0, 0])
    rail_C();
}

//translate([(2*wall_radius + spacing/2), 0, 0])
//sled_with_rails(maze_a);
//positioned_rails();

//translate([.07,0,0]) cube([.1,.1,.03]);
//translate([0,0,.125]) rotate(-atan(sqrt(2)), v=[1,-1,0]) rail(0.15);
