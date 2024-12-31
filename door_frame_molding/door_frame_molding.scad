include <../Round-Anything/polyround.scad>
include <../BOSL2/std.scad>
include <../BOSL2/beziers.scad>

baseH = 6.5;
baseW = 103;
centerH = 8;
centerW = 72;
circleR = 5;
circleGap = 0.5;
ridgeH = 5;
ridgeW = 20;
ridgeRounding = 2;
length = 133;

module ridge() {
    translate([3*circleR+2*circleGap, baseH/2+centerH, 0]) {
        polygon(polyRound([
            [0, 0, 0], 
            [ridgeW, 0, 0], 
            [ridgeW, ridgeH, ridgeRounding], 
            [ridgeH/2, ridgeH, ridgeRounding]
        ]));
    }
}

module curve() {
    curveStartX = 3*circleR+2*circleGap+ridgeW;
    curveStartY = baseH/2+centerH+2;

    bez = [
        [curveStartX, curveStartY], 
        [curveStartX+5, curveStartY], 
        [curveStartX+7, curveStartY-5], 
        [curveStartX+9, curveStartY-10], 
        [baseW/2, baseH/2]
    ];
    bezier_points = bezier_curve(bez);
    anchor_points = [
        [centerW/2, baseH/2],
        [curveStartX, curveStartY], 
        [baseW/2, baseH/2]
    ];
    polygon(concat(anchor_points, bezier_points));
    //debug_bezier(bez, N=len(bez)-1, width=0.25);
}

//curve();

module molding() {
    union() {
        // Base
        square([baseW, baseH], center=true);

        // Center
        translate([0, baseH/2+centerH/2, 0]) {
            square([centerW, centerH], center=true);
        }

        // Circles
        translate([0, baseH/2+centerH, 0]) {
            // Center Circle
            circle(circleR);
            // Right Circle
            translate([2*circleR+circleGap, 0, 0]) {
                circle(circleR);
            }
            // Left Circle
            translate([-2*circleR-circleGap, 0, 0]) {
                circle(circleR);
            }    
        }

        // Ridge Right
        ridge();
        // Ridge Left
        mirror([1, 0, 0]) {
            ridge();
        }

        // Curve Right
        curve();
        // Curve Left
        mirror([1, 0, 0]) {
            curve();
        }
    }
}

linear_extrude(length) {
    molding();
}
