include <../BOSL2/std.scad>

$fn=100;

height=50;
radius=40;
thickness=5;

clip_length=height;
clip_width=20;
clip_gap=8;
clip_depth=20;

text_str = "Jasmine";
text_font = "Script MT Bold";
letter_spacing = 8.75;
text_size = 12;
text_depth = 2;
text_emboss = false;

module cup_text() {
    color("silver", 1.0)
    translate([0, 0, -text_size/2]) {
        path_text(
            path3d(arc(100, r=radius, start=0, angle=180)), 
            text_str, 
            size=text_size, 
            lettersize=[letter_spacing, letter_spacing, letter_spacing*0.65, letter_spacing*1.3, letter_spacing*0.45, letter_spacing*0.9, letter_spacing, letter_spacing], 
            thickness=text_depth, 
            center=true,
            font=text_font
        );

        path_text(
            path3d(arc(100, r=radius, start=180, angle=180)), 
            text_str, 
            size=text_size, 
            lettersize=[letter_spacing, letter_spacing, letter_spacing*0.65, letter_spacing*1.3, letter_spacing*0.45, letter_spacing*0.9, letter_spacing, letter_spacing], 
            thickness=text_depth,
            center=true,
            font=text_font
        );
    }
}

union() {
    // Cup
    difference() {
        cyl(h=height, r=radius, center=true, rounding=thickness/2);
        translate([0, 0, thickness]) {
            cyl(h=height-thickness, r=radius-thickness, center=true, rounding=thickness/2);
        }
        
        if (!text_emboss) {
            cup_text();
        }
    }
   
    // Clip
    difference() {
        translate([radius+clip_depth/2-thickness, 0, 0]) {
            cuboid([clip_depth, clip_width, clip_length], rounding=thickness/2);
        }
        translate([radius+clip_depth/2-thickness, 0, -thickness]) {
            cuboid([clip_gap, clip_width+thickness, clip_length], rounding=thickness/2);
        }
    }
    
    if (text_emboss) {
        cup_text();
    }
    
}
