//include <my_extrusion_A.scad>
include <my_extrusion_B.scad>

//include <my_extrusion_C.scad>
//color([.5,0,0]) my_extrusion_C();
include <my_extrusion_D.scad>
include <my_extrusion_E.scad>
include <my_extrusion_F.scad>
//my_extrusion_F();
//cut_cube();
cube_bottom();

circle_inner = 0.4;
circle_outer = 0.49;
circle_h = 0.1;
cut_w = 0.02;


/* work in progress
difference() {
    
    cube_bottom();
    translate([1,1,1]*((1+0.8)/3-circle_h/sqrt(3)))
    rotate(-atan(sqrt(2)), v=[1,-1,0]) {
        translate([0,0,-0.01]) cylinder(circle_h+0.02, circle_inner, circle_inner, $fn=36);
        rotate(-45) rotate_extrude(angle=60, convexity=4, $fn=36) translate([(circle_inner+circle_outer)/2, -.1, 0]) square([cut_w, 0.3]);
    }
    
}
*/


module hollow_cube() {
    difference() {
        cube([1,1,1]);
        translate([1,1,1]*.03) cube([1,1,1]*.94);
    }
}
//hollow_cube();


cube_thickness = 0.12;
module cube_corner () {
    size = 0.65;
    translate([1-size, 0, 1-cube_thickness])
    cube([size, size, cube_thickness]);
    translate([1-size, 0, 1-size])
    cube([size, cube_thickness, size]);
    translate([1-cube_thickness, 0, 1-size])
    cube([cube_thickness, size, size]);
}
//cube_corner();
/*
module cube_corner2() {

    h = 0.6; // TODO depends on x
    r1 = sqrt(1/2)*h;
    eps = 0.02;
    difference() {
        cube_corner();
        rotate(-atan(sqrt(2)), v=[1,-1,0])
        translate([0,0,sqrt(3) - h/2])
        cylinder(h, r1+eps, eps, center=true, $fn=40);
    }
    
    //rotate(-atan(sqrt(2)), v=[1,-1,0])
    //    translate([0,0,sqrt(3) - h/2])
    //    cylinder(h, r1+eps, eps, center=true, $fn=40);
    
    
}
*/
//cube_corner2();

module make_corner_receive() {
difference()
{
    //hollow_cube();
    cube_corner();
    children();
}
}

eps = 0.01;
module make_corner_give() {
    difference() {
        cube_corner();
        minkowski(convexity=10) {
            make_corner_receive() children();
            //cube([1,1,1]*eps, center=true);
            sphere(eps);
        }
        
    }
}

rotation = -0;
translation = 0.0;


module cube_bottom() {
    make_corner_receive() my_extrusion_E();
    
    rotate(-120, v=[1,1,1]) make_corner_receive() my_extrusion_E();
    
    rotate(-240, v=[1,1,1]) make_corner_receive() my_extrusion_E();
    
    //translate([1,1,1]*((1+0.8)/3-circle_h/sqrt(3)))
    //rotate(-atan(sqrt(2)), v=[1,-1,0])
    //cylinder(circle_h, circle_outer, circle_outer, $fn=36);
}

module cube_top() {
    translate([1,1,1]*translation) rotate(-60*rotation, v=[1,1,1]) make_corner_give() my_extrusion_E();
    translate([1,1,1]*translation)rotate(-120-60*rotation, v=[1,1,1]) make_corner_give() my_extrusion_E();
    translate([1,1,1]*translation)rotate(-240-60*rotation, v=[1,1,1]) make_corner_give() my_extrusion_E();
}

/*
rotate(-60*1, v=[1,1,1])
intersection()
{
    //hollow_cube();
    cube_corner();
    my_extrusion_C();
}
*/


/*
color([.5,0,0]) translate([0,0,-0.0]){
hollow_cube();
rotate(60*1, v=[1,1,1]) hollow_cube();
}

translate([.5, 0, 1]) cube([1,1,1]*0.01, center=true);
*/