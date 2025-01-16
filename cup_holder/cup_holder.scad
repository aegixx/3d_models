include <../lib/BOSL2/std.scad>
use <../fonts/FontdinerSwanky-Regular.ttf>;

$fn=100;

module test_cup(height, top_radius, bottom_radius, thickness) {
    difference() {
        color("cyan")
        cyl(h=height, r1=bottom_radius, r2=top_radius, center=false);
        
        color("blue")
        translate([0, 0, thickness])
        cyl(h=height-thickness+1, r1=bottom_radius-thickness, r2=top_radius-thickness, center=false);
    }
}

module cup_holder(height, top_radius, bottom_radius, thickness, rounding) {

    base_height=height*0.6;
    cup_height=height*0.4;
    cup_thickness=thickness;
    inner_cup_height=cup_height-cup_thickness;

    base_radius=bottom_radius;
    outer_cup_radius=top_radius;
    inner_cup_radius=top_radius-cup_thickness;

    clip_width=20;
    clip_gap=5;
    clip_thickness=thickness;

    // Letter spacing multiplier, 1 = normal, 2 = double, 0.5 = half
    // Defaults to 1 for each letter
    module cup_text(text, size, radius=0, font="Fontdiner Swanky", depth=2, letter_spacing=[], start=0) { 
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
        union() {
            // Outer Cup
            color("white")
            cyl(h=cup_height, r=outer_cup_radius, center=false, rounding2=rounding);

            // Base
            color("silver")
            translate([0, 0, -base_height])
            cyl(h=base_height, r1=base_radius, r2=outer_cup_radius, center=false, rounding1=rounding);

            // Clip
            color("yellow")
            rotate([0, 5, 0])
            translate([outer_cup_radius+clip_thickness/2-rounding, 0, cup_height/2]) {
                difference() {
                    diff()
                    prismoid(size1=[clip_thickness*2+clip_gap, clip_width/2], size2=[clip_thickness*2+clip_gap, clip_width], height=cup_height, center=true, rounding=rounding)
                        edge_profile([TOP+RIGHT, BOTTOM])
                            mask2d_roundover(r=clip_gap, mask_angle=$edge_angle, $fn=64);

                    translate([0, 0, -clip_gap])
                    cuboid([clip_gap, clip_width*2, cup_height], rounding=clip_gap/2);
                }
            }
        }

        // Inner Cup
        color("grey")
        translate([0, 0, cup_height-inner_cup_height]) 
        cyl(h=inner_cup_height+1, r=inner_cup_radius, center=false, rounding1=rounding, rounding2=-rounding);

        // Cup Text
        translate([0, 0, cup_height/2]) {
            cup_text(
                text="Buddy",
                size=cup_height/4,
                depth=2,
                letter_spacing=[1, 0.75, 0.8, 0.9, 1],
                start=0,
                radius=outer_cup_radius
            );
            cup_text(
                text="Buddy",
                size=cup_height/4,
                depth=2,
                letter_spacing=[1, 0.75, 0.8, 0.9, 1],
                start=180,
                radius=outer_cup_radius
            );
        }
    }
}

// Cup Holder
cup_holder(height=125, top_radius=85/2, bottom_radius=60.325/2, thickness=5, rounding=1);

// (TEST) Soda = 122.7mm tall, 66mm diam
// test_cup(height=122.7, top_radius=66/2, bottom_radius=66/2, thickness=1);

// (TEST) Coffee Cup = 114.3mm tall, 88.9mm diam top, 60.325mm diam bottom
// test_cup(height=114.3, top_radius=88.9/2, bottom_radius=60.325/2, thickness=1);

// (TEST) Pup Cup = 63.5mm tall, 63.5mm diam top, 44.45mm diam bottom
// test_cup(height=63.5, top_radius=63.5/2, bottom_radius=44.45/2, thickness=1);

// (TEST) Pup Bowl = 60mm tall, 90mm diam top, 80mm diam bottom
// test_cup(height=60, top_radius=90/2, bottom_radius=80/2, thickness=1);
