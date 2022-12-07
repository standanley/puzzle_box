include <extrude_test2.scad>
include <mazes.scad>
include <rails.scad>


//bottom_A();
//latch_top();
//latch_bottom();


//cube_Z();
//cube_A();
//cube_B();
//cube_C();
//cube_D();
//cube_E();


//maze_print(maze_a);
//maze_print(maze_b);
//maze_print(maze_c);

//print_Z();
//print_A();
//print_B();
//print_C();
//print_D();
//print_E();

print_rails();


wall_thickness = 0.05;
cut_depth = wall_thickness*1.001;
cut_width = 0.007;

visualization_eps = 0.001;
cut_ZA = sqrt(3)/6;
cut_AB = sqrt(3)/3;
cut_BC = 0.9;
cut_DE = 1.25;


module print_rails() {
    for(i=[0:2]) {
        translate([0,i*3*(w+d),0])
        {
            translate([0,0,h])
            rotate(180,[0,1,0])
            rail_A();
            
            translate([0,w+d,h])
            rotate(180,[0,1,0])
            rail_B();
            
            translate([0,2*(w+d),h])
            rotate(180,[0,1,0])
            rail_C();
        }
    }
}

module print_Z() {
    translate([0,0,cut_ZA]) rotate(180+atan(sqrt(2)), v=[1,-1,0]) translate([0,0,0])cube_Z();
}
module print_A() {
    translate([0,0,cut_AB]) rotate(180+atan(sqrt(2)), v=[1,-1,0]) translate([0,0,0])cube_A();
}
module print_B() {
    translate([0,0,cut_BC]) rotate(180+atan(sqrt(2)), v=[1,-1,0]) translate([0,0,0])cube_B();
}
module print_C() {
    translate([0,0,-cut_BC]) rotate(atan(sqrt(2)), v=[1,-1,0]) translate([0,0,0])cube_C();
}
module print_D() {
    translate([0,0,cut_DE]) rotate(180+atan(sqrt(2)), v=[1,-1,0]) translate([0,0,0])cube_D();
}
module print_E() {
    translate([0,0,-cut_DE]) rotate(atan(sqrt(2)), v=[1,-1,0]) translate([0,0,0])cube_E();
}

module cut1(points) {
    //function warp(p) = [p[0]*sqrt(3)/2, p[1] - p[0]*1/2];
    function warp(p) = [p[0]/sqrt(2), (p[1] - p[0]*1/2)/sqrt(3/2)];
    
    width = cut_width;
    
    
    
    rotate(180-atan(sqrt(2)), v=[1,-1,0]) 
    rotate(-45)
    translate([0,0,-1.2])
    linear_extrude(height=2, center=false, convexity=10)
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
    pattern = [[.8,0],[.7,.03], [.55,.12],[.62,.15],[.65,.25],[.56,.28],[.55,.4],[.45,.38],[.38,.29],[.3, .3]];
    difference() {
        cube_slice(cut_ZA+visualization_eps, cut_AB);
        cut_all(pattern);
    }
}


module cube_B() {
    // NOTE to avoid visual weirdness, the first angle made by 
    // pattern1 and pattern2 have to follow some relationship
    pattern1 = [[1,.2], [.9, .2], [.82,.3],[.88,.4],[.9,.35],[.93,.5],[.8,.45],[.77,.5],[.65,.5],[.68,.63],[.66,.66]];
    pattern2 = [[1.0, .8], [0.9, 0.7], [.85, .85]];
    difference() {
        cube_slice(cut_AB+visualization_eps, cut_BC - visualization_eps);
        cut_all(pattern1);
        translate([1,1,1]) rotate(60, [1,1,1]) mirror([1,1,1])  cut_all(pattern2);
    }
}

//
//cube_slice(cut_ZA+visualization_eps, cut_AB);
//cube_slice(cut_AB+visualization_eps, cut_BC-visualization_eps);

//cube_slice(cut_CD+visualization_eps, 2);


module cube_D() {
    rotate(180-atan(sqrt(2)), v=[1,-1,0]) translate([0,0,-cut_DE])rotate(270) latch_top();
}
module cube_C() {
    rotate(-atan(sqrt(2)), v=[1,-1,0]) translate([0,0,cut_BC])latch_bottom();
}


module cube_E() {
    pattern = [[.58,0],[.62,.12],[.4,.07],[.5,.18],[.4,.2],[.22,.08],[.15,.08],[.2,.17],[.16,.16]];
    difference() {
        cube_slice(cut_DE+visualization_eps, 2);
        translate([1,1,1]) rotate(60, [1,1,1]) mirror([1,1,1])  cut_all(pattern);
    }
    //translate([1,1,1])mirror([1,1,1])  cut_all(pattern);
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