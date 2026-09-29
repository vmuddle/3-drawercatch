// A catch fro the drawers in Jayco caravan.
// Problem to solve is the Pot Drawer, it seems the catch does not meet the latch, as it is too short.  I feel that it could be more robust and thicker as well.

// assume that WIDTH=front to back
// assume that THICKNESS=height.
// assume that this object is upside down.
// assume that LENGTH=left to right

screwHoleDiameter=4;
plateWidth=18;
plateLength=52+18;
plateThickness=5;
catchWidth=4.0;
catchThickness=plateThickness+10-0.5;
catchLength=16+10;

holeSpacing=27+18-18;



module hole(depth=plateThickness) {
    spacingA=(screwHoleDiameter*2)/2;
    spacingB=(plateWidth-((screwHoleDiameter*2)+2));
    spacing=(spacingA > spacingB) ? spacingB : spacingA;
    hull() {
        translate([-spacing,0,-depth/2]) {
            cylinder(h=depth, d=screwHoleDiameter, $fn=360);
        }
        translate([spacing,0,-depth/2]) {
            cylinder(h=depth, d=screwHoleDiameter, $fn=360);
        }
    }
}

module holes(newSpacing=holeSpacing/2) {
    spacing=newSpacing;
    translate([0,-spacing,0]) {
        hole();
    }
    translate([0,spacing,0]) {
        hole();
    }
}

module plate() {
    difference() {
        //cube([plateWidth,plateLength,plateThickness], true);
        #hull() {
            translate([-plateWidth/2,-plateLength/2,-plateThickness/2]) {
                cylinder(h=plateThickness, d=1, $fn=64);
            }
            translate([-plateWidth/2,plateLength/2,-plateThickness/2]) {
                cylinder(h=plateThickness, d=1, $fn=64);
            }
            translate([plateWidth/2,-plateLength/2,-plateThickness/2]) {
                cylinder(h=plateThickness, d=1, $fn=64);
            }
            translate([plateWidth/2,plateLength/2,-plateThickness/2]) {
                cylinder(h=plateThickness, d=1, $fn=64);
            }
        }
        //holes(newSpacing=holeSpacing/2);
        holes(newSpacing=((holeSpacing/2)+(screwHoleDiameter*2)));
        holes(newSpacing=((holeSpacing/2)+(screwHoleDiameter*4)));
        translate([-3,0,-plateThickness/2]) {
            cylinder(h=plateThickness, d=screwHoleDiameter, $fn=360);
        }
        translate([-3.25,0,-(plateThickness/2)+2]) {
            cylinder(h=plateThickness, d=screwHoleDiameter*2.75, $fn=360);
        }
    }
}

module strengtheners() {
    translate([0,catchLength/3,0]) {
        cylinder(h=catchThickness, d=0.2);
    }
    translate([0,catchLength/6,0]) {
        cylinder(h=catchThickness, d=0.2);
    }
    translate([0,0,0]) {
        cylinder(h=catchThickness, d=0.2);
    }
    translate([0,-catchLength/6,0]) {
        cylinder(h=catchThickness, d=0.2);
    }
    translate([0,-catchLength/3,0]) {
        cylinder(h=catchThickness, d=0.2);
    }
}

module catch() {
    translate([((plateWidth-catchWidth)/2),0,catchThickness-(plateThickness*2)]) {
        difference() {
            hull() {
                translate([-catchWidth/2,0,1]) {
                    cube([catchWidth/2,catchLength,catchThickness], true);
                }
                translate([0,(catchLength-catchWidth)/2,(catchThickness-catchWidth)/2]) {
                    sphere(d=catchWidth, $fn=8);
                }
                translate([0,-(catchLength-catchWidth)/2,(catchThickness-catchWidth)/2]) {
                    sphere(d=catchWidth, $fn=8);
                }
                // Bottom
                translate([0.25,(catchLength-catchWidth+2)/2,(-catchWidth/2)]) {
                    sphere(d=catchWidth+0.5, $fn=64);
                }
                translate([0.25,-(catchLength-catchWidth+2)/2,(-catchWidth)/2]) {
                    sphere(d=catchWidth+0.5, $fn=64);
                }
            }
            
        }
    }
    %translate([2,catchLength/2,catchThickness/2]) {
        cube([catchWidth/2,catchLength,catchThickness], true);
    }
}

difference() {
    union() {
        plate();
        catch();
    }
    #translate([5,0,-(3+(catchThickness*0))]) {
        strengtheners();
    }
    #translate([7.5,0,-(3+(catchThickness*0))]) {
        strengtheners();
    }
}
