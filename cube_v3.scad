include <extrude_test2.scad>
include <rails.scad>
include <print_cube.scad>


cut_latch_alpha = 0.95;
cut_latch_beta = 1.2;
latch_beta_cutout = 0.58;

//rotate(atan(sqrt(2)), v=[1,-1,0])
//cube_alpha();

//translate([0,0,sqrt(3)]) rotate(180+atan(sqrt(2)), v=[1,-1,0]) 
//cube_beta();

//cube_C();
//cube_D();
//latch_beta();
//latch_alpha();


module cube_alpha() {
    pattern1 = [[.2,0],[.3,.07],[.22,.15],[.1,.1]];
    pattern2 = [[.8,0],[.7,.03], [.55,.12],[.62,.15],[.65,.25],[.56,.28],[.55,.4],[.45,.38],[.38,.29],[.3, .3]];
    pattern3a = [[1,.2], [.9, .2], [.82,.3],[.88,.4],[.9,.35],[.93,.5],[.8,.45],[.77,.5],[.65,.5],[.68,.63],[.66,.66]];
    pattern3b = [[1.0, .8], [0.9, 0.7], [.85, .85]];
    
    
    difference() {
        union() {
            difference() {
                cube();
                translate([wall_thickness,wall_thickness,wall_thickness])
                cube([1,1,1]*(1-2*wall_thickness));
                rotate(-atan(sqrt(2)), v=[1,-1,0])
                translate([0,0,
        1+cut_latch_alpha+0.01])
                cube([2,2,2], center=true);
                
                cut_all(pattern1);
                cut_all(pattern2);
                cut_all(pattern3a);
            }
            latch_alpha();
        }

        translate([1,1,1]) rotate(60, [1,1,1]) mirror([1,1,1])
        cut_all(pattern3b);
    
    }
    
    
    
    translate([0,0,1]) rail_B();
    rotate(120, [1,1,1]) translate([0,0,1]) rail_B();
    rotate(240, [1,1,1]) translate([0,0,1]) rail_B();
    
}
module cube_beta() {
    pattern4 = [[.58,0],[.62,.12],[.4,.07],[.5,.18],[.4,.2],[.22,.08],[.15,.08],[.2,.17],[.16,.16]];
    difference() {
        cube();
        translate([wall_thickness,wall_thickness,wall_thickness])
        cube([1,1,1]*(1-2*wall_thickness));
        rotate(-atan(sqrt(2)), v=[1,-1,0])
        translate([0,0,-1+cut_latch_beta-0.01])
        cube([2,2,2], center=true);
        
        translate([1,1,1]) rotate(60, [1,1,1]) mirror([1,1,1])
        cut_all(pattern4);
    }
    
    latch_beta();
    
    translate([0,0,1]) {
        rail_A_positioned();
        rail_C_positioned();
    }
    rotate(120, [1,1,1]) translate([0,0,1])  {
        rail_A_positioned();
        rail_C_positioned();
    }
    rotate(240, [1,1,1]) translate([0,0,1])  {
        rail_A_positioned();
        rail_C_positioned();
    }
}

module latch_alpha() {
    
    difference() {
        cube_bottom();
        
        magic_pyramid();
        
        //rotate([0,0,180])
        //rotate(atan(sqrt(2)), v=[1,-1,0])
        //translate([0,0,-1+cut_latch_alpha])
        //cube([2,2,2], center=true);
        
    }
}
module latch_beta() {
    difference() {
        cube_top();
        
        rotate(-atan(sqrt(2)), v=[1,-1,0])
        linear_extrude(2)
        rotate(45)
        circle(latch_beta_cutout,$fn=3);
    }
}


module magic_pyramid() {
    // magic shape to cut away to allow the wall thickness to change gradually
    // "Angle" is the overhang angle we have to print, but it's helped by some nearby things with more gradual overhang
    // if you want to adjust angle, you will have to adjust angle_radius too
    // I never want to touch it again
    flat_radius = 0.56;
    angle = 50;
    angle_radius = 0.98;
    
    
    rotate(-atan(sqrt(2)), v=[1,-1,0])
    translate([0,0,.5]) rotate(45)
    difference() {
        cube(1.65, center=true);
        for (i = [0:2] ) {
            translate([0,0,1.7])
            cube(2, center=true);
            
            rotate(120*i)
            translate([flat_radius,0,0])
            translate([1,0,0]) cube(2, center=true);
            
            
            rotate(60+120*i)
            translate([angle_radius,0,0])
            rotate(-angle, [0,1,0])
            translate([1,0,0]) cube(2, center=true);
        }
    }
}

 //magic_pyramid();