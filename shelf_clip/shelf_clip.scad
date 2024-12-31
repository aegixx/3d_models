baseL = 10.66;
baseW = 9.63;
baseH = 5.12;
height = 17.14;
pinCenter = 4.41;
pinL = 8.23;
pinD = 5;

union() {
    cube([baseW, baseL, baseH]);

    // Define the vertices of the pyramid
    vertices = [
        [0, 0, 0],  // Base - Bottom left corner
        [baseW, 0, 0], // Base - Bottom right corner
        [baseW, baseL, 0],// Base - Top right corner
        [0, baseL, 0], // Base - Top left corner
        [0, baseL/2, height]  // Apex of the pyramid
    ];

    // Define the faces of the pyramid
    faces = [
        [0, 1, 4], // Side 1
        [1, 2, 4], // Side 2
        [2, 3, 4], // Side 3
        [3, 0, 4], // Side 4
        [3, 2, 1, 0] // Base
    ];

    translate([0, 0, baseH]) {
        // Create the pyramid using the polyhedron function
        polyhedron(points = vertices, faces = faces);
    }


    translate([-pinL/2, baseL/2, pinCenter]) {
        rotate([0, 90, 0]) {
            cylinder(h=pinL, d=pinD, center=true, $fn=100);
        }
    }
}