wall_radius = 0.05;//1/22;
//wall_shrink = 0.002;
spacing = (1-2*wall_radius)/5;//hall_thickness + wall_radius * 2;
hall_thickness = spacing - wall_radius*2;
pointer_thickness = hall_thickness - 0.02;
fn = 16;
pointer_shorten = 0.02;




//special_sphere(1);

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

module special_sphere(r) {
    // make edges line up with cylinders
    rotate([0,-90,0])
    rotate_extrude($fn=fn) {
        difference() {
            circle(r, $fn=fn);
            translate([-2*r,0,0])
            square(4*r, center=true);
        }
    }
}

module wall_segment(length, radius1, radius2) {
    r1 = radius1;// - wall_shrink;
    r2 = radius2;// - wall_shrink;
    union () {
        translate([0,0,0]) cylinder(length, r1, r2, $fn=fn);
        translate([0,0,0]) special_sphere(r1, $fn=fn);
        translate([0,0,length]) special_sphere(r2, $fn=fn);
    }
}
//wall_segment(1, .2, .2);

module wall(x, y, r, length, shorten1, shorten2, radius1=wall_radius, radius2=wall_radius) {
    l2 = length - (shorten1 + shorten2) * radius1;
    translate([x, y, 0]) {
        rotate([0,90,r]) {
            translate([0,0,shorten1*radius2]) wall_segment(l2, radius1, radius2);
        }
    }
}

pointer_radius = hall_thickness/2;
corner = (pointer_radius + wall_radius)*sqrt(2)/spacing;
// pointer offset happens to be exactly one wall diameter 
pointer_offset = 2*wall_radius/spacing;
maze_a = [
// surrounding walls
[corner, 0, 0, 5-corner, 0, 0],
[0, corner, 90, 5-corner, 0, 0],
[0, 5, 0, 5-corner, 0, 0],
[5, 0, 90, 5-corner, 0, 0],

// straight pieces for rounded start cap
[0, corner, 225, (2*wall_radius*sqrt(2)+2*wall_radius)/spacing, 0, 0],
[corner, 0, 225, (2*wall_radius*sqrt(2)+2*wall_radius)/spacing + 0, 0, 0],

// pointer
//OLD [5, 5-corner, 45, 1, 0, 0],
//OLD [5-corner, 5, 45, 1, 0, 0],
// Pointer now handled in maze function
//[5-corner, 5, 45, pointer_offset*sqrt(2), 0, 0],
//[5-corner+pointer_offset, 5+pointer_offset, 0, corner-pointer_offset + 1.0*pointer_offset, 0, 0],

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
//[5-corner, 5, 45, pointer_offset*sqrt(2), 0, 0],
//[5-corner+pointer_offset, 5+pointer_offset, 0, corner-pointer_offset + 1.0*pointer_offset, 0, 0],

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
//[5-corner, 5, 45, pointer_offset*sqrt(2), 0, 0],
//[5-corner+pointer_offset, 5+pointer_offset, 0, corner-pointer_offset + 1.0*pointer_offset, 0, 0],

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
    translate([-2.5*spacing, -2.5*spacing, 0]) {
        for (si = info) {
            wall(spacing*si[0], spacing*si[1], si[2], spacing*si[3], si[4], si[5]);
        }
        
        // contents of union are shared among mazes
        union() { 
            // pointer
            wall(spacing*(5-corner), spacing*5, 45, spacing*pointer_offset*sqrt(2), 0, 0, radius2=pointer_radius);
            wall(spacing*(5-corner+pointer_offset), spacing*(5+pointer_offset), 0, spacing*(corner-pointer_offset)+3*wall_radius - pointer_shorten, 0, 0, radius1=pointer_radius, radius2=pointer_radius);
            
            // rounded start cap
            r = wall_radius;//-wall_shrink;
            translate([-pointer_offset*spacing, -pointer_offset*spacing, 0])
            rotate([0,0,135])
            rotate_extrude(angle=180, convexity = 10, $fn=fn*2)
            translate([pointer_radius + wall_radius, 0, 0])
            rotate(270)
            circle(r = r, $fn=fn);
            
            // bridges for stiffness
            bridge_inset = corner*spacing/2;
            translate([bridge_inset, bridge_inset,0]) bridge();
            translate([5*spacing-bridge_inset,5*spacing-bridge_inset,0]) bridge();
            
            
            
        }
    
    }
}

module bridge() {
            bridge_angle = 100;
            // span length of sqrt(2)*corner, scaled by spacing
            // sin(bridge_angle)*2*r = dist
            bridge_dist = sqrt(2)*corner * spacing;
            bridge_r = bridge_dist/(2*sin(bridge_angle));
            bridge_height = -bridge_r*cos(bridge_angle);
            translate([0,0,bridge_height])
            rotate(45, [0,0,1])
            rotate(-90, [0,1,0])
            rotate(-bridge_angle)
            rotate_extrude(angle=bridge_angle*2, convexity = 10, $fn=fn*2)
            translate([bridge_r, 0, 0])
            rotate(270)
            circle(r = wall_radius*0.7, $fn=fn);
}

//maze(maze_a);