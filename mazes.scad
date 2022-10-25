wall_radius = 1/22;
wall_shrink = 0.002;
spacing = (1-2*wall_radius)/5;//hall_thickness + wall_radius * 2;
hall_thickness = spacing - wall_radius*2;
pointer_thickness = hall_thickness - 0.01;
fn = 15;

slide_init = 1*0.99*spacing;
together = 2*spacing + 0*0.51*spacing + 0*spacing*$t;
slide_a = slide_init + together + 0*spacing;
slide_b = slide_init + together + 0*spacing;
slide_c = slide_init + together + 0*spacing;




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