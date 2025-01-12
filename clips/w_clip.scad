include <../lib/BOSL2/std.scad>
include <../lib/Round-Anything/polyround.scad>

$fn=100;

debug = false;
testing = false;

module w_clip(depth=20, width=30, length=60, gap=1, thickness=4) {

    l = length;
    t = thickness;
    x1 = (width - 3 * thickness) / 2;
    x2 = width / 3;
    x_mid = width/2;

    points = [
        [0, 0, 0.5],                // 0
        [x_mid-x1, 0, 0.5],         // 1
        [x2, -l/4, 0.5],            // 2
        [x_mid, 0, 0.5],            // 3
        [2*x2, -l/4, 0.5],          // 4
        [x_mid+x1, 0, 0.5],         // 5
        [width, 0, 0.5],            // 6
        [x_mid+gap/2, -l, 0.5],     // 7
        [x_mid+2*gap, -l/3.5, 5],     // 8
        [x_mid, -l/3.75, 5],        // 9
        [x_mid-2*gap, -l/3.5, 5],     // 10
        [x_mid-gap/2, -l, 0.5]      // 11
    ];

    linear_extrude(height=depth)
    polygon(polyRound(points));


    if (debug) {
        color("blue") stroke(points, 0.25, closed=true);
        for(i = [0:1:len(points)-1]) {
            point = points[i];
            x = point[0];
            y = point[1];
            color("red") translate(point) circle(d=2);
            color("black") translate([x, y, 0]) text(str(i), size=1, valign="center", halign="center");
        }
    }
}

if (testing) {
    w_clip();
}