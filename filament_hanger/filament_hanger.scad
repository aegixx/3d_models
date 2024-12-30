$fn = 100;

hangerDiam = 50;
hangerLen = 80;
capDepth = 5;
capDiam = hangerDiam * 1.25;
mountHeight = capDiam / 2 + 15;
mountWidth = capDiam;
mountDepth = 5;
holeDiam = 4;

difference() {
    union() {
        rotate([-90, 0, 0]) {
            difference() {
                union() {
                    cylinder(h=hangerLen, d=hangerDiam);
                    cylinder(h=capDepth, d=capDiam);
                }
                
                translate([-hangerDiam * 1.25 / 2, 0, -hangerLen * 0.25 / 2]) {
                    cube([hangerDiam * 1.25, hangerDiam * 1.25, hangerLen * 1.25]);
                }
            }
            
        }

        translate([-mountWidth/2, hangerLen, 0]) {
            cube([mountWidth, mountDepth, mountHeight]);
        }
    }

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