$fn = 100;

capDiam = 50;
hangerDiam = capDiam - 10;
hangerLen = 80;
capDepth = 5;
mountHeight = capDiam / 2 + 15;
mountWidth = capDiam;
mountDepth = 5;
holeDiam = 4;

difference() {
    union() {
        // hanger rod + cap
        rotate([-90, 0, 0]) {
            difference() {
                union() {
                    // hanger rod
                    color("red") 
                    cylinder(h=hangerLen, d=hangerDiam);
                    
                    // hanger cap
                    color("blue")
                    cylinder(h=capDepth, d=capDiam);
                }

                // exclude bottom-half to make half-cylinders
                exclusionWidth = capDiam + 2;
                exclusionLen = hangerLen + capDepth + 2;
                color("yellow") 
                translate([-exclusionWidth/2, 0, -1]) {
                    cube([exclusionWidth, exclusionWidth, exclusionLen]);
                }
            }
            
        }

        // mount plate
        color("green")
        translate([-mountWidth/2, hangerLen, 0]) {
            cube([mountWidth, mountDepth, mountHeight]);
        }
    }

    // screw holes
    translate([0, hangerLen-mountDepth/2, mountHeight*.75]) {
        rotate([-90, 0, 0]) {
            translate([-mountWidth/4, 0, 0]) {
                cylinder(h=mountDepth*2, d1=holeDiam*2, d2=holeDiam);
            }

            translate([mountWidth/4, 0, 0]) {
                cylinder(h=mountDepth*2, d1=holeDiam*2, d2=holeDiam);
            }
        }
    }
}