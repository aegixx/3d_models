include <../lib/BOSL2/std.scad>

$fn=100;

module w_clip(thickness=30, width=30, length=60) {

    union() {
        stroke_width = width/10;

        w_expansion = width/5;
        w_length = length / 3;

        clip_gap = width/5;

        w_points = [
            [0, 0], // Top Left
            [w_expansion, -w_length], // Bottom Left
            [2*w_expansion, 0], // Top Middle
            [3*w_expansion, -w_length], // Bottom Right
            [4*w_expansion, 0] // Top Right
        ];

        color("red")
        linear_extrude(height=thickness)
        stroke(w_points, stroke_width*1.5);

        // Point on W to connect left side of clip to
        left_connect_x = w_points[1][0] + w_expansion/2;
        left_connect_y = w_points[1][1] + w_length/2;
        left_connect = [left_connect_x, left_connect_y];

        middle_connect = [2*w_expansion, 0];

        // Point on W to connect right side of clip to
        right_connect_x = w_points[3][0] - w_expansion/2;
        right_connect_y = w_points[3][1] + w_length/2;
        right_connect = [right_connect_x, right_connect_y];

        clip_points = [
            [0, 0], // Top-Left Connect
            [-clip_gap, 0], // Top Left
            [width/2-clip_gap/2-stroke_width, -length], // Bottom Left
            left_connect,    // Connect to bottom-left W
            middle_connect, // Connect to top-middle W
            right_connect,   // Connect to bottom-right W
            [width/2, -length], // Bottom Right
            [width, 0], // Top Right
            [width-clip_gap, 0] // Top-Right Connect
        ];

        color("blue")
        linear_extrude(height=thickness)
        stroke(clip_points, stroke_width);
    }
}

w_clip();