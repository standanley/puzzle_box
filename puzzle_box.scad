include <extrude_test2.scad>
//cut_cube();
cube();
//cube_top();
//cube_bottom();

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
wall_radius = 1/22;
wall_shrink = 0.002;
spacing = (1-2*wall_radius)/5;//hall_thickness + wall_radius * 2;
hall_thickness = spacing - wall_radius*2;
pointer_thickness = hall_thickness - 0.01;
fn = 10;

slide_init = 1*0.99*spacing;
together = 2*spacing + 0*0.51*spacing + 0*spacing*$t;
slide_a = slide_init + together + 0*spacing;
slide_b = slide_init + together + 0*spacing;
slide_c = slide_init + together + 0*spacing;

translate([0,0,1]) {
    //rails();
    translate([slide_a, 0, 0]) color([0.5, 0, 0]) sled(maze_a);
}
translate([0,1,0]) rotate([-90,-90,0]) {
    //rails();
    translate([slide_b, 0, 0]) color([0, .5, 0]) sled(maze_b);
}
translate([1,0,0]) rotate([90,0,90]) {
    //rails();
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
module sled(maze_info) {
    //translate([rail_thickness,rail_thickness,0]) cube([1-rail_thickness, 2*rail_thickness, rail_thickness]);
    //translate([rail_thickness, 2*rail_thickness, rail_thickness]) cube([1-rail_thickness, rail_thickness, rail_thickness]);
    
    translate([0,1,0]) mirror([0,1,0]) {
    //translate([rail_thickness,rail_thickness,0]) cube([1-rail_thickness, 2*rail_thickness, rail_thickness]);
    //translate([rail_thickness, 2*rail_thickness, rail_thickness]) cube([1-rail_thickness, rail_thickness, rail_thickness]);
    }
    
    
    
    
    //translate([0,1-3*rail_thickness,0]) cube([1, 2*rail_thickness, rail_thickness]);
    //translate([0, 1-3*rail_thickness, rail_thickness]) cube([1, rail_thickness, rail_thickness]);
    
    // old pointer attempts
    //translate([wall_radius + spacing/2 - pointer_thickness/2, 1 - 3*rail_thickness, 2*rail_thickness]) cube([pointer_thickness, 5*rail_thickness + wall_radius, pointer_thickness]);
    //translate([-pointer_thickness, 1, 0]) cube([pointer_thickness, 1.5*2*wall_radius, pointer_thickness]);
    //translate([-pointer_thickness, 1-0.3, 0]) cube([pointer_thickness, 0.2, pointer_thickness]);
    
    

    translate([0.5, 0.5, wall_radius]) rotate(90) maze(maze_info);
       /*
    difference() {
        translate([0.5, 0.5, wall_radius]) rotate(90) maze(maze_info);
        minkowski() {
            rails();
            cube(rail_clearance, center=true);
        }
    }
    */
    
}


module wall_segment(length) {
    r = wall_radius-wall_shrink;
    union () {
        translate([0,0,0]) cylinder(length, r, r, $fn=fn);
        translate([0,0,0]) sphere(r, $fn=fn);
        translate([0,0,length]) sphere(r, $fn=fn);
    }
}

module wall(x, y, r, length, shorten1, shorten2) {
    l2 = length - (shorten1 + shorten2) * wall_radius;
    translate([x, y, 0]) {
        rotate([0,90,r]) {
            translate([0,0,shorten1*wall_radius]) wall_segment(l2);
        }
    }
}

corner = 2*wall_radius*sqrt(2)/spacing;
// pointer offset happens to be exactly one wall diameter 
pointer_offset = 2*wall_radius/spacing;
maze_a = [
[corner, 0, 0, 5-corner, 0, 0],
[0, corner, 90, 5-corner, 0, 0],
[0, 5, 0, 5-corner, 0, 0],
[5, 0, 90, 5-corner, 0, 0],

[0, corner, 225, (2*wall_radius*sqrt(2)+2*wall_radius)/spacing, 0, 0],
[corner, 0, 225, (2*wall_radius*sqrt(2)+2*wall_radius)/spacing + 0, 0, 0],
//[5, 5-corner, 45, 1, 0, 0],
//[5-corner, 5, 45, 1, 0, 0],
[5-corner, 5, 45, pointer_offset*sqrt(2), 0, 0],
[5-corner+pointer_offset, 5+pointer_offset, 0, corner-pointer_offset + 1.0*pointer_offset, 0, 0],

[1, 0, 90, 4, 0, 0],
[1, 4,  0, 1, 0, 0],
[1, 2,  0, 2, 0, 0],
[3, 1, 90, 1, 0, 0],
[2, 1,  0, 1, 0, 0],

[3, 3, 90, 2, 0, 0],
[2, 3,  0, 1, 0, 0],

[4, 0, 90, 4, 0, 0],

//[0, 0, 225, 1, 0, 0],
];


maze_b = [
[corner, 0, 0, 5-corner, 0, 0],
[0, corner, 90, 5-corner, 0, 0],
[0, 5, 0, 5-corner, 0, 0],
[5, 0, 90, 5-corner, 0, 0],

[0, corner, 225, (2*wall_radius*sqrt(2)+2*wall_radius)/spacing, 0, 0],
[corner, 0, 225, (2*wall_radius*sqrt(2)+2*wall_radius)/spacing + 0, 0, 0],
//[5, 5-corner, 45, 1, 0, 0],
//[5-corner, 5, 45, 1, 0, 0],
[5-corner, 5, 45, pointer_offset*sqrt(2), 0, 0],
[5-corner+pointer_offset, 5+pointer_offset, 0, corner-pointer_offset + 1.0*pointer_offset, 0, 0],

[1, 1, 0, 4, 0, 0],

[2, 2, 0, 3, 0, 0],
[0, 2, 0, 1, 0, 0],

[1, 3, 0, 4, 0, 0],

[2, 4, 0, 3, 0, 0],
[0, 4, 0, 1, 0, 0],

];

maze_c = [
[corner, 0, 0, 5-corner, 0, 0],
[0, corner, 90, 5-corner, 0, 0],
[0, 5, 0, 5-corner, 0, 0],
[5, 0, 90, 5-corner, 0, 0],

[0, corner, 225, (2*wall_radius*sqrt(2)+2*wall_radius)/spacing, 0, 0],
[corner, 0, 225, (2*wall_radius*sqrt(2)+2*wall_radius)/spacing + 0, 0, 0],
//[5, 5-corner, 45, 1, 0, 0],
//[5-corner, 5, 45, 1, 0, 0],
[5-corner, 5, 45, pointer_offset*sqrt(2), 0, 0],
[5-corner+pointer_offset, 5+pointer_offset, 0, corner-pointer_offset + 1.0*pointer_offset, 0, 0],

[2, 0, 90, 2, 0, 0],
[1, 1, 0, 1, 0, 0],
[1, 1, 90, 3, 0, 0],

[2, 3, 90, 2, 0, 0],
[2, 4,  0, 1, 0, 0],
[3, 1, 90, 3, 0, 0],
[3, 1,  0, 1, 0, 0],
[4, 1, 90, 1, 0, 0],

[4, 4,  0, 1, 0, 0],
[4, 3, 90, 1, 0, 0],

];


module maze(info) {
    translate([-2.5*spacing, -2.5*spacing, 0])
    for (si = info) {
        wall(spacing*si[0], spacing*si[1], si[2], spacing*si[3], si[4], si[5]);
        
    r = wall_radius-wall_shrink;
    translate([-pointer_offset*spacing, -pointer_offset*spacing, 0])
    rotate([0,0,135])
    rotate_extrude(angle=180, convexity = 10, $fn=fn)
    translate([2*wall_radius, 0, 0])
    rotate(90)
    circle(r = r, $fn=fn);
    
    }
}