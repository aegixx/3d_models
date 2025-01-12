include <../lib/BOSL2/std.scad>
use <../fonts/FontdinerSwanky-Regular.ttf>;
include <../clips/w_clip.scad>

$fn=100;

module cup(height, radius, thickness=5, rounding=2) {
    // Letter spacing multiplier, 1 = normal, 2 = double, 0.5 = half
    // Defaults to 1 for each letter
    module cup_text(text, size, font="Fontdiner Swanky", depth=2, letter_spacing=[], start=0) { 
        color("grey")
        translate([0, 0, -size/2]) {
            path_text(
                path=path3d(arc(100, r=radius, start=start, angle=180)), 
                text=text, 
                font=font,
                size=size, 
                lettersize=[for (i = [0 : len(text) - 1]) size * (len(letter_spacing) > 0 ? letter_spacing[i] : 1)],
                thickness=depth, 
                center=true
            );
        }
    }

    difference() {
        color("white")
        difference() {
            cyl(h=height, r=radius, center=true, rounding=rounding);
            translate([0, 0, thickness]) {
                cyl(h=height, r=radius-thickness, center=true, rounding=rounding);
            }
        }
        cup_text(
            text="Buddy",
            size=height/4,
            depth=2,
            letter_spacing=[1, 0.75, 0.8, 0.9, 1],
            start=0
        );
        cup_text(
            text="Buddy",
            size=height/4,
            depth=2,
            letter_spacing=[1, 0.75, 0.8, 0.9, 1],
            start=180
        );
    }
    
}

module base(height, r1, r2, rounding=2) {
    color("yellow")
    translate([0, 0, -height/2])
    cyl(h=height, r1=r1, r2=r2, center=true, rounding=rounding);
}

module clip(depth, width, length, gap=2) {
    color("red")
    translate([-depth/2, width/2, 0]) {
        rotate([90, 0, 0])
        w_clip(depth=depth, width=width, length=length, gap=gap);
    }
}

full_height = 122.7; // Same as can of soda
cup_height=full_height/2;
base_height=cup_height/3*2;

base_radius=33; // Same as can of soda
cup_radius=base_radius;
cup_thickness=5;

clip_width=20;
clip_gap=1;
clip_depth=20;

rounding=1;

difference() {
    union() {
        cup(
            height=cup_height, 
            radius=cup_radius,
            thickness=cup_thickness,
            rounding=rounding
        );
        translate([0, 0, -cup_height/2+2*rounding])
        base(
            height=base_height,
            r1=base_radius*0.9,
            r2=base_radius,
            rounding=rounding
        );
        translate([cup_radius+clip_depth/2-clip_gap*2, 0, cup_height/2-5])
        rotate([0, 9, 0])
        clip(
            width=clip_width,
            length=cup_height,
            depth=clip_depth,
            gap=clip_gap
        );
    }

}