include <extrude_test2.scad>
include <mazes.scad>
include <rails.scad>

//bottom_A();
maze_print(maze_a);
//maze_print(maze_b);
//maze_print(maze_c);


module bottom_A() {
    rotate(-atan(sqrt(2)), v=[1,-1,0])
    translate([0,0,((1+0.5)/sqrt(3))]) 
    difference() {
        translate([0,0,-1*((1+0.5)/sqrt(3))]) rotate(atan(sqrt(2)), v=[1,-1,0]) cube_bottom();
        translate([0,0,1]) cube([2,2,2], center=true);
    }
}



/*
translate([0,0,1.3]) rotate([180,0,0]) rotate(atan(sqrt(2)), v=[1,-1,0])
    cube_top();
    translate([0,0,-1]) cube([2,2,2], center=true);
*/


module maze_print(maze1) {
    translate([0,1,wall_radius*2])
    rotate([180,0,0])
    sled_with_rails(maze1);
}