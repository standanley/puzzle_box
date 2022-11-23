include <extrude_test2.scad>
include <mazes.scad>
include <rails.scad>

//bottom_A();
//maze_print(maze_a);
//maze_print(maze_b);
//maze_print(maze_c);
//latch_top();
//latch_bottom();
cube_Z();
cube_A();
cube_B();
cube_C();
cube_D();
cube_E();

wall_thickness = 0.05;
cut_depth = wall_thickness/2;

visualization_eps = 0.01;
cut_ZA = sqrt(3)/6;
cut_AB = sqrt(3)/3;
cut_BC = 0.9;
cut_DE = 1.25;

module cut1(points) {
    //function warp(p) = [p[0]*sqrt(3)/2, p[1] - p[0]*1/2];
    function warp(p) = [p[0]/sqrt(2), (p[1] - p[0]*1/2)/sqrt(3/2)];
    
    width = 0.008;
    
    
    
    rotate(180-atan(sqrt(2)), v=[1,-1,0]) 
    rotate(-45)
    translate([0,0,-1])
    linear_extrude(height=1, center=false, convexity=10)
    for ( i = [0 : len(points)-2]) {
        p1_unwarp = points[i];
        p2_unwarp = points[i+1];
        p1 = warp(p1_unwarp);
        p2 = warp(p2_unwarp);
        translate([p1[0], p1[1], 0]) circle(width/2, $fn=10);
        translate([p2[0], p2[1], 0]) circle(width/2, $fn=10);
        length = sqrt((p1[0]-p2[0])^2 + (p1[1]-p2[1])^2);
        angle = atan2(p2[1]-p1[1], p2[0]-p1[0]);
        //echo(angle);
        
        
        translate([p1[0], p1[1], 0])
        rotate(angle)
        translate([length/2, 0, 0])
        square([length, width], center=true); 
        
    }
}

module cut_all(points) {
    difference() {
        union() {
        cut1(points);
            mirror([-1, 0, 1]) cut1(points);
            rotate(120,[1,1,1]) {
                cut1(points);
                mirror([-1, 0, 1]) cut1(points);
            }
            rotate(240,[1,1,1]) {
                cut1(points);
                mirror([-1, 0, 1]) cut1(points);
            }
        }
        translate([1,1,1]/sqrt(3)*cut_depth) cube();
    }
}


//cut1();

module cube_Z() {
    pattern = [[.2,0],[.3,.07],[.22,.15],[.1,.1]];
    difference() {
        cube_slice(-1, cut_ZA);
        cut_all(pattern);
    }
}
module cube_A() {
    pattern = [[.7,0], [.55,.12],[.65,.25],[.3, .3]];
    difference() {
        cube_slice(cut_ZA+visualization_eps, cut_AB);
        cut_all(pattern);
    }
}


module cube_B() {
    pattern = [[1,.2], [.9, .25]];
    difference() {
        cube_slice(cut_AB+visualization_eps, cut_BC - visualization_eps);
        cut_all(pattern);
    }
}

//
//cube_slice(cut_ZA+visualization_eps, cut_AB);
//cube_slice(cut_AB+visualization_eps, cut_BC-visualization_eps);

//cube_slice(cut_CD+visualization_eps, 2);


module cube_C() {
    rotate(180-atan(sqrt(2)), v=[1,-1,0]) translate([0,0,-cut_DE])rotate(270) latch_top();
}
module cube_D() {
    rotate(-atan(sqrt(2)), v=[1,-1,0]) translate([0,0,cut_BC])latch_bottom();
}


module cube_E() {
    pattern = [[1,.2], [.9, .25]];
    difference() {
        cube_slice(cut_DE+visualization_eps, 2);
        cut_all(pattern);
    }
}

module cube_slice(start, end) {
    difference() {
        cube();
        translate([1,1,1]*wall_thickness) cube([1,1,1]*(1-2*wall_thickness));
        
        
        //translate([0,0,1]) cube([2,2,2], center=true);
        //translate([0,0,-1*((1+0.5)/sqrt(3))]) rotate(atan(sqrt(2)), v=[1,-1,0]) cube();
        rotate(-atan(sqrt(2)), v=[1,-1,0]) translate([0,0,-1+start]) cube([2,2,2],center=true);
        rotate(-atan(sqrt(2)), v=[1,-1,0]) translate([0,0,1+end]) cube([2,2,2],center=true);
        
    }
}

module bottom_A() {
    rotate(-atan(sqrt(2)), v=[1,-1,0])
    translate([0,0,((1+0.5)/sqrt(3))]) 
    difference() {
        translate([0,0,-1*((1+0.5)/sqrt(3))]) rotate(atan(sqrt(2)), v=[1,-1,0]) cube_bottom();
        translate([0,0,1]) cube([2,2,2], center=true);
    }
}



module latch_top(){
    difference(){
        translate([0,0,cut_DE]) rotate([180,0,0]) rotate(atan(sqrt(2)), v=[1,-1,0])
        cube_top();
        translate([0,0,-1]) cube([2,2,2], center=true);
    }
}

module latch_bottom(){
    difference(){
        translate([0,0,-cut_BC])
        //rotate([180,0,0])
        rotate(atan(sqrt(2)), v=[1,-1,0])
        cube_bottom();
        
        translate([0,0,-1]) cube([2,2,2], center=true);
    }
}


module maze_print(maze1) {
    translate([0,1,wall_radius*2])
    rotate([180,0,0])
    sled_with_rails(maze1);
}