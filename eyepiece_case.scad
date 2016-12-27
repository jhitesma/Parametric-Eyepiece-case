/* [Eyepiece Parameters] */
// Outer diameter of eyepiece shaft in mm
eyepiece_shaft_diameter = 23.15;
// Length of eyepiece shaft in mm
eyepiece_shaft_length = 15;
// Outer diameter of eyepiece top section in mm
eyepiece_ext_od = 28;
// Length of eyepiece top section in mm
eyepiece_ext_length = 10;

/* [Case Parameters] */
// Wall thickness of case in mm
case_thickness = 2;

/* [Print Parameters] */
part = "case"; // [case:Case Only, all:Case and fake eyepiece, eyepiece:Eyepiece Only,top_only:Case Top Only,bot_only:Case Bottom Only]

/* [Hidden] */
bot_length = eyepiece_shaft_length + 2 + case_thickness*2;
bot_r = (eyepiece_ext_od/2) + case_thickness;

top_length = eyepiece_shaft_length + 2 + eyepiece_ext_length + (case_thickness*2);
top_r = bot_r + case_thickness;

pad = 1.05;

$fs = 0.1;
$fa = 6;

print_part();

module print_part() {
    if (part == "eyepiece") {
        rotate([0,180,0])
        translate([0,0,-(top_length)])
        eyepiece();
    } else if (part == "top_only") {
        rotate([0,180,0])
        translate([0,0,-(top_length + case_thickness)])
        case_top();
    } else if (part == "bot_only") {
        case_bottom();
    } else if (part == "case") {
        rotate([0,180,0])
        translate([top_r*2+10, 0 ,-(top_length + case_thickness)]) 
        case_top();
        case_bottom();
    } else if (part == "all") {
        rotate([0,180,0])
        translate([top_r*2+10, 0 ,-(top_length + case_thickness)]) 
        case_top();
        translate([top_r*2+10, 0 ,0]) 
        case_bottom();        
        translate([0,0,-case_thickness])
        rotate([0,180,0])
        translate([0,0,-(top_length + case_thickness)])
        eyepiece();
    }
}


module case_top() {
    difference() {
        union() {
            translate([0,0,(top_length/2) + eyepiece_ext_length])
            cylinder(top_length/2, top_r, top_r, true);
        }
        scale([pad,pad,1]) eyepiece();
        case_bottom();
    }
}

module case_bottom() {

    difference() {
        translate([0,0,bot_length/2])
        cylinder(bot_length, bot_r, bot_r, true);
        scale(pad,pad,1]) eyepiece();
    }
};



module eyepiece() {
    union() {
        eyepiece_shaft();
        eyepiece_ext();
    }
}

module eyepiece_shaft() {
        translate([0,0,case_thickness + (eyepiece_shaft_length + (eyepiece_ext_length-1))/2]) 
        cylinder(eyepiece_shaft_length + (eyepiece_ext_length-1), eyepiece_shaft_diameter/2, eyepiece_shaft_diameter/2, true);    
}

module eyepiece_ext() {
        translate([0,0,case_thickness + eyepiece_shaft_length + (eyepiece_ext_length-1)])
        cylinder(eyepiece_ext_length, eyepiece_ext_od/2, eyepiece_ext_od/2, true);   
}