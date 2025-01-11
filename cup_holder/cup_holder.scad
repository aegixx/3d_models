include <../lib/BOSL2/std.scad>
use <../fonts/FontdinerSwanky-Regular.ttf>;

$fn=100;

height=50;
radius=40;
thickness=5;

clip_length=height;
clip_width=20;
clip_gap=8;
clip_depth=20;

text_str = "Buddy";
text_font = "Fontdiner Swanky";
text_size = 12;
text_depth = 2;

module cup_text() { 
    // Letter spacing multiplier, 1 = normal, 2 = double, 0.5 = half
    letter_spacing = [1, 0.75, 0.75, 0.9, 1];
    
    color("white")
    translate([0, 0, -text_size/2]) {
        path_text(
            path3d(arc(100, r=radius, start=0, angle=180)), 
            text_str, 
            font=text_font,
            size=text_size, 
            lettersize=[for (i = [0 : len(letter_spacing) - 1]) text_size * letter_spacing[i]],
            thickness=text_depth, 
            center=true
        );
    }
}

module cup() {
    color("silver")
    difference() {
        cyl(h=height, r=radius, center=true, rounding=thickness/2);
        translate([0, 0, thickness]) {
            cyl(h=height-thickness, r=radius-thickness, center=true, rounding=thickness/2);
        }
    }
}

module clip() {
    path3d(points=[
        [0, 0], // Top Left
        [5, -10], // Bottom Left
        [10, 0], // Top Middle
        [15, -10], // Bottom Right
        [20, 0] // Top Right
    ]);
}

// difference() {
//     union() {
//         cup();
//         clip();
//     }

//     cup_text();
// }

clip();