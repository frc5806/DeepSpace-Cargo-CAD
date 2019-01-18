$fn=100;
//---- utility functions ----//
function inchesToMm(x) = 25.4*x;

//---- game pieces ----//
module small_ball(){
    color("orange") sphere(d=11);
}
module med_ball(){
    color("orange") sphere(d=13);
}
module big_ball(){
    color("orange") sphere(d=15);
}
module our_ball(){
    color("orange") sphere(d=13.5);
}

//---- kop parts (from frclib) ----//
module cim() {
    bodyHeight = 4.315;
    edgeHeight = 0.25;

    translate([0,0,0.197]) {
        translate([0,0,edgeHeight]) color([0.2,0.2,0.2]) cylinder(r=1.26,h=4.315-2*edgeHeight);
        color([0.75,0.75,0.75]) cylinder(r=1.26,h=edgeHeight);

        color([0.75,0.75,0.75]) difference() {
            translate([0,0,4.315-edgeHeight])  cylinder(r=1.26,h=edgeHeight);
            translate([1,0,0]) cylinder(r=0.08,h=10);
            translate([-1,0,0]) cylinder(r=0.08,h=10);
        }
    } color([0.75,0.75,0.75]) cylinder(r=0.6,h=0.197);

    color([0.75,0.75,0.75]) translate([0,0,0.197+bodyHeight]) {
        cylinder(r=0.375,h=0.157);
        cylinder(r=0.16,h=1.402);
    }
}

module hex(diam,length) {
    cylinder(r=diam/2,h=length,$fn=6);
}




//---- cargo modules ----//
module shovel(width, height, extension){
    //bottom plate 
    color() translate([0,1.5,00.125]) cube([width,10.5,0.25],center=true);
    //back plate
    translate([-1*(width/2),7,0]) rotate([90,0,0]) cube([width,height-1,0.25]);
    color("cyan",0.2){
        //angled wall left
       //translate([5.9,7,0]) rotate([90,0,-79]) cube([11,height-1,0.25]);
        //angled wall right
       //translate([-6.15,7,0]) rotate([90,0,261]) cube([11,height-1,0.25]);
    }
    //frame
    color("grey"){
        //vertical posts
        translate([(width/2)-1,7,0]) rotate([0,0,0]) cube([1,1,height]);
        translate([-1*(width/2),7,0]) rotate([0,0,0]) cube([1,1,height]);
        //wall posts
        translate([(width/2)-0,7.5,0]) rotate([39.4,0,0]) cube([1,1,18.1177]);
        translate([-(width/2)-1,7.5,0]) rotate([39.4,0,0]) cube([1,1,18.1177]);
        //top horizontal across
        translate([-1*(width/2),7,height]) rotate([0,90,0]) cube([1,1,width]);
        //top horizontal extending
        translate([-1*(width/2),7,height]) rotate([0,90,270]) cube([1,1,extension]);
        translate([(width/2)-1,7,height]) rotate([0,90,270]) cube([1,1,extension]);
    }  
}

module roller(diam){
    translate([-9,0,0]) rotate([0,90,0]) hex(0.5,18);
    //compliant (shooter) wheels
    color("green"){
        translate([-1.5,0,0]) rotate([0,90,0]) cylinder(1,d=diam);
        translate([0.5,0,0]) rotate([0,90,0]) cylinder(1,d=diam);
        translate([-3.5,0,0]) rotate([0,90,0]) cylinder(1,d=diam);
        translate([2.5,0,0]) rotate([0,90,0]) cylinder(1,d=diam);
        translate([-5.5,0,0]) rotate([0,90,0]) cylinder(1,d=diam);
        translate([4.5,0,0]) rotate([0,90,0]) cylinder(1,d=diam);
    }
    //mecanum (centering) wheels
    /**
    color("red"){
        translate([-6.5,0,0]) rotate([0,90,0]) cylinder(2,d=diam);
        translate([-4,0,0]) rotate([0,90,0]) cylinder(2,d=diam);
        translate([4.5,0,0]) rotate([0,90,0]) cylinder(2,d=diam);
        translate([2,0,0]) rotate([0,90,0]) cylinder(2,d=diam);
    }
    **/
    
}

module io(width, height, extension, wheel_diam){
    translate([0,-1*(extension-8),height-0.5]) roller(wheel_diam);
    //translate([-width/2-0.7,-1*(extension-8),height-0.5]) color("pink") rotate([90,0,270]) gear (basediameter, depth, degrees, dedendum, addendum, toothwidth, teethnumber, toothshape);
    //translate([-width/2-1.7,-1*(extension-8)+1.0,height-0.5]) color("blue") rotate([90,0,0]) gear (basediameter, depth, degrees, dedendum, addendum, toothwidth, teethnumber, toothshape);
    shovel(width, height, extension);
    //translate([-width/2-1.7,2.3,height-0.5]) rotate([90,0,0]) cim();
    //color("brown") translate([-width/2-3,-1,height-2]) rotate([0,0,0]) cube([3,2,3]);
}

module chassis(){
    //horizontal bottom front
     color ("purple") translate([-9,8,0]) rotate([0,0,0]) cube([18,1,1]);
    
    //horizontal bottom back
    color ("purple") translate([-15,25,0]) rotate([0,0,0]) cube([30,1,1]);
    
    //side front
    color ("purple") translate([-10,9,0]) rotate([0,0,-90]) cube([7,1,1]);
    color ("purple") translate([9,9,0]) rotate([0,0,-90]) cube([7,1,1]);
    
    //bottom back
    color ("red") translate([-7.35,9,0]) rotate([0,0,90]) cube([16,1,1]);
    color ("red") translate([8.35,9,0]) rotate([0,0,90]) cube([16,1,1]);
    
    //top back
    color ("red")translate([-7.35,9,12]) rotate([0,0,90]) cube([16,1,1]);
    color ("red") translate([8.35,9,12]) rotate([0,0,90]) cube([16,1,1]);
    
    //vertical front
    color ("red") translate([-7.35,9,0]) rotate([0,-90,90]) cube([13,1,1]);
    color ("red") translate([8.35,9,0]) rotate([0,-90,90]) cube([13,1,1]);
    
    //vertical back
    color ("red") translate([-7.35,26,0]) rotate([0,-90,90]) cube([13,1,1]);
    color ("red") translate([8.35,26,0]) rotate([0,-90,90]) cube([13,1,1]);
    
    //bottom back
    color ("purple") translate([-12.35,2,0]) rotate([0,0,90]) cube([24,1,1]);
    color ("purple") translate([13.35,2,0]) rotate([0,0,90]) cube([24,1,1]);
    
    //side front
    color ("purple") translate([-15,1,0]) rotate([0,0,0]) cube([6,1,1]);
    color ("purple") translate([9,1,0]) rotate([0,0,0]) cube([6,1,1]);
}

module arm(){
    color("pink"){
    rotate([-5,0,0]){
   translate([0,0,0]) rotate([-90,0,0]) cylinder(14.39,d=1.56);
   translate([0,-1,0]) rotate([-90,0,0]) cylinder(7,d=0.5);
   translate([-0.25,14.25,0.5]) rotate([-90,0,0]) cube([0.5,1,1.25]);
   translate([-10,0,0]){
       translate([0,0,0]) rotate([-90,0,0]) cylinder(14.39,d=1.56);
       translate([0,-1,0]) rotate([-90,0,0]) cylinder(7,d=0.5);
       translate([-0.25,14.25,0.5]) rotate([-90,0,0]) cube([0.5,1,1.25]);
   }
   translate([4,15,0]) rotate([90,0,990]) hex(0.5,18);
   }
   }
}

module hatch(){
    //allotting this much space for hatch mech
    color("yellow") translate([-4.5,16,1]) rotate([0,0,0]) cube([9,9,9]);
}

//---- main ----//
translate([0,0,7]) our_ball();
io(width=14,height=14,extension=14.5,wheel_diam=4);
chassis();
translate([5,9,13.75]) rotate([0,0,0]) arm();
hatch();






/*---------------------------------------------------------*/
//---- bevel gears, copied, pasted, and adjusted from https://github.com/startling/bevel-gears/blob/master/bevelgears.scad ----//

basediameter = 1;   // pitch diameter of widest part 
depth = 1;           // depth of the gear
holediam = 1;        // diameter of center hole
teethnumber = 20;    // number of teeth
toothwidth = 1;      // width of teeth
addendum = 1/2;      // addendum
dedendum = 1/2;      // dedendum
toothshape = 1;   // how much of the tooth is triangular			                // for no triangles, make it 0
				 // otherwise it should be a fraction
centercircles = 0;   // number of center circles
				 // if you don't want any, put 0
				 // they are radially centered
centercircdiam = 2;  // diameter of center circles


//Bevel Parameters

degrees = 60;        // base angle of the gear
				 // 90 for a regular spur gear
				 // negative numbers are possible
extendbevel = 0;     // creates a spur top for bevel gears 
				 // only works if rbasediameter = 0
				 // 1 is on, 0 is off
bdepth = 3;          // thickness of extended bevel 
basedepth = 2;       // depth of the flat base at the bottom
				 // to turn it off, just make it 0

//Rome Gear Parameters:

rbasediameter = 0;   // pitch diameter of widest part
				 // to turn Rome gear off, make it 0
rdegrees = 90;       // base angle
rdepth = 2;          // thickness
rteeth = 10;         // number of teeth
rtwidth = 1;         // tooth width
raddendum = 1/4;     // addendum
rdedendum = 1/4;     // dedendum
rtoothshape = 1;

// Modules

module gear (diam1, thick, angle, ded, add, twidth, tnumber, toothfraction)
 {

	//Trig to find top diameter:

	triangbase = thick / tan(angle);
	topdiameter =  (diam1 - 2 * triangbase) - ded;

	//Miscellaneous variables:

	bottomdiameter = diam1 - ded;
	howmuchistri = toothfraction * (add + ded);
	toothlength = (add + ded) - howmuchistri; 
	xthick = twidth/2;

	union() {

		difference () {

			cylinder(h = thick, r1 = bottomdiameter/2, r2 = topdiameter/2, $fn = 75, center = true);
			cylinder(h = 2*thick, r = holediam / 2, center = true, $fn = 75);
			centershape(thick, topdiameter);

			}

		}

		for ( i = [1:tnumber] ) {

			rotate( i*360/tnumber, [0, 0, 1])
			translate ([0, 0, thick / -2])

			geartooth (bottomdiameter, topdiameter, xthick, toothlength, thick, howmuchistri);

		}

}

module centershape (thick, diam) {

if (centercircles > 0) {

	for ( f = [1:centercircles] ) {

		rotate( f*360/centercircles, [0, 0, 1])
		translate ([diam/4, 0, 0 ])
		cylinder ( h = 2*thick, r = centercircdiam/2, $fn = 75, center = true);

	}

}

}

module geartooth (diam1, diam2, xthickness, tlength, zthick, point){

// Sorry... polyhedra are so messy in openSCAD
// In case you're wondering, the following polyhedra are one
// tooth. The first is rectangular, the second has triangles.

	if (point == 0) {

	polyhedron ( points = 
[[-xthickness, diam2/2, zthick], [-xthickness, tlength + diam2/2, zthick], [-xthickness, tlength + diam1/2, 0], [-xthickness, diam1/2, 0], [xthickness, diam2/2, zthick], [xthickness, tlength + diam2/2, zthick], [xthickness, tlength + diam1/2, 0], [xthickness, diam1/2, 0]
], triangles = [[0,2,1], [0,3,2],[3,0,4],[1,2,5],[0,5,4],[0,1,5],[5,2,6],[7,3,4],[4,5,6],[4,6,7],[6,2,7],[2,3,7]]);

	}

	if (point > 0 ) {

		polyhedron ( points = 
[[-xthickness, diam2/2, zthick], [-xthickness, tlength + diam2/2, zthick], [-xthickness, tlength + diam1/2, 0], [-xthickness, diam1/2, 0], [xthickness, diam2/2, zthick], [xthickness, tlength + diam2/2, zthick], [xthickness, tlength + diam1/2, 0], [xthickness, diam1/2, 0],[0, tlength + diam2/2 + point, zthick],[0, tlength + diam1/2 + point, 0]
], triangles = [[0,2,1], [0,3,2],[3,0,4],[1,2,8],[0,5,4],[0,1,5],[5,9,6],[7,3,4],[4,5,6],[4,6,7],[6,2,7],[2,3,7],[1,8,5],[2,6,9],[2,9,8],[5,8,9],]);

	}

}


if (rbasediameter > 0) {

	translate ([0, 0, depth/2 + rdepth/2])
	gear (rbasediameter, rdepth, rdegrees, rdedendum, raddendum, rtwidth, rteeth, rtoothshape);

}

//More trig to find top diameter:

	triangbase = depth / tan(degrees);
	topdiameter =  (basediameter - 2 * triangbase);

if (rbasediameter == 0 && extendbevel == 1) {

	translate ([0, 0, depth/2 + bdepth/2])
	gear (topdiameter, bdepth, 90, dedendum, addendum, toothwidth, teethnumber);

}








