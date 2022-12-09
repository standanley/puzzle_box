include <cube_v3.scad>


alpha1();
alpha2();

module section(mirror_axis) {
    translate([.5,.5,.5])
    mirror(mirror_axis)
    scale(2)
    rotate(45)
    translate([0,0,-0.5])
    cylinder(0.5,sqrt(2)/2,0, $fn=4);
}

module alpha1() {
    intersection() {
        cube_alpha();
        section([0,0,0]);
    }
}
module alpha2() {
    intersection() {
        cube_alpha();
        section([1,0,1]);
    }
}

module beta1() {
    
    intersection() {
        cube_beta();
        section([0,0,1]);
    }
}