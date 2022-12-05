include <extrude_test2.scad>
include <mazes.scad>
include <rails.scad>
include <print_cube.scad>
//cut_cube();
//cube();
//cube_top();
//cube_bottom();

cube_Z();
cube_A();
cube_B();
cube_C();
cube_D();
cube_E();

box_thickness = 0.1;
//translate([-2.0,0,0]) 
//rotate(-atan(sqrt(2))*(cos(360*$t)+1)/2, v=[1,1,1])base_bottom();

slice_height = 0.9;
slice_distance = (1+slice_height)/sqrt(3);
slice_point = 2.2;

circle_radius = 0.5;

module base_bottom() {
    difference() {
        cube([1,1,1]);
        rotate(-atan(sqrt(2)), v=[1,-1,0]) translate([0,0,1]*(slice_distance+1)) cube([1,1,1]*2, center=true);
        translate([1,1,1]*box_thickness) cube([1,1,1]*(1-2*box_thickness));
    };
    
    
    rotate(-atan(sqrt(2)), v=[1,-1,0]) translate([0,0,slice_distance]) {
        //cube([1,1,1]*.2);
        //circle();
        difference() {
            cylinder(0.05, circle_radius, circle_radius, $fn=30);
            translate([0,0,-0.01]) cylinder(0.05*2, circle_radius-0.01, circle_radius-0.01, $fn=30);
        }
    }
    
    /*
    translate([1,0,1])
    translate([-0.18,.03,0])
    rotate(45)
    rotate(90)
    scale(0.1)
        polygon([
            [0,0],
            [1,0],
            [1,1],
            [2,1],
            [2,0],
            [3,0],
            [3,-1],
            [0,-1]
        ]);
    */
    
}

//translate([0,0,0]) base_top();

module base_top() {
    color([1, .5, 0]) difference() {
        cube([1,1,1]);
        rotate(-atan(sqrt(2)), v=[1,-1,0]) cube([1,1,1]*slice_point, center=true);
    };
    
}

rail_thickness = 0.03;
rail_clearance = 0.01;




translate([0,0,1]) {
    positioned_rails();
    translate([slide_a, 0, 0]) color([0.5, 0, 0]) sled_with_rails(maze_a)
    ;
}
translate([0,1,0]) rotate([-90,-90,0]) {
    positioned_rails();
    translate([slide_b, 0, 0]) color([0, .5, 0]) sled(maze_b);
}
translate([1,0,0]) rotate([90,0,90]) {
    positioned_rails();
    translate([slide_c, 0, 0]) color([.2, .2, .5]) sled(maze_c);
}



module rails() {
    
    cube([1, rail_thickness - rail_clearance, rail_thickness*2-rail_clearance]);
    translate([0, rail_thickness - rail_clearance,rail_thickness+rail_clearance]){
        cube([1, rail_thickness - rail_clearance, rail_thickness - 2*rail_clearance]);
    }
    translate([0, rail_thickness - rail_clearance, 0]) cube([rail_thickness, rail_thickness - rail_clearance, rail_thickness + rail_clearance]);
    
    //translate([0,1 - rail_thickness + rail_clearance,0]) {
    //    cube([1, rail_thickness - rail_clearance, rail_thickness*2-rail_clearance]);
    //}
    //translate([0, 1-2*rail_thickness + 2*rail_clearance,rail_thickness+rail_clearance]){
    //    cube([1, rail_thickness - rail_clearance, rail_thickness - 2*rail_clearance]);
    //}
    
    translate([0,1,0]) mirror([0,1,0]) {
    cube([1, rail_thickness - rail_clearance, rail_thickness*2-rail_clearance]);
    translate([0, rail_thickness - rail_clearance,rail_thickness+rail_clearance]){
        cube([1, rail_thickness - rail_clearance, rail_thickness - 2*rail_clearance]);
    }
    translate([0, rail_thickness - rail_clearance, 0]) cube([rail_thickness, rail_thickness - rail_clearance, rail_thickness + rail_clearance]);
    }
}

module sled_old() {
    translate([0,rail_thickness,0]) cube([1, 2*rail_thickness, rail_thickness]);
    translate([0, 2*rail_thickness, rail_thickness]) cube([1, rail_thickness, rail_thickness]);
    translate([0,1-3*rail_thickness,0]) cube([1, 2*rail_thickness, rail_thickness]);
    translate([0, 1-3*rail_thickness, rail_thickness]) cube([1, rail_thickness, rail_thickness]);
    translate([0, 0, 2*rail_thickness]) cube([1,1,rail_thickness]);
}
