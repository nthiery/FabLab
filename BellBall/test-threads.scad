use <threads.scad>

metric_thread(diameter=8,length=2, pitch=.2,n_segments=16, n_starts=2);

translate([10,0,0])
difference() {
    cylinder(d=10,h=1.8);
    translate([0,0,-.1])
    metric_thread(diameter=8, length=2, n_segments=16, n_starts=2, internal=True);
}
