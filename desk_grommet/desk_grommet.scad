$fn=100;

innerD = 12;
outerD = 15;
rodH = 30;
capH = 3;

difference() {
    union() {
        cylinder(capH, outerD, outerD);
        cylinder(rodH, outerD/2, outerD/2);
    }
    
    translate([0, 0, -rodH/2]) {
        cylinder(rodH*3, innerD/2, innerD/2);
    }
} 