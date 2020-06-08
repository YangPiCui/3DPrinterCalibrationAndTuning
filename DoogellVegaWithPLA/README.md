

# Doogell Vega Calibration and Tuning

Bought 2nd hand for $500.   
Greased rails. Cleaned belt and belt housing.  
Replaced bed cover with tempered sanded-surface glass.  
Pressed printer frame against wall to steady the former.  
Use Cura 4.6.1 as the slicer software.  
  
In a multi-parameter optimization, if one parameter changes, multiple other parameters have to change, too. For example, if we change the layer height, the print speed and the flow rate both have to change (in an unpredictable manner) to ensure the same print accuracy. Fixing as many parameters as possible upfront would simply the optimization.

## Part 0: Optimize Independent Parameters

### 3D Printer Specification  
CoreXY structure; Linear XY Rails;  
X/Y resolution = 0.1mm;  
Z resolution = ?; //<=0.1 mm  

X direction = ↓; X range = 0-250;  
Y direction = →, Y range = 0-293; //Belt starts to slip at 294  
Z direction = up, Z range = 0-300;  
Rectangular; Heated bed; G-code flavor = RepRap;  
  
Printhead ([how these values are defined](https://community.ultimaker.com/topic/18484-printhead-settings/))  
X min = -29; //measured in the negative x direction  
Y min = -37; //measured in the negative y direction  
X max = 60; //measured in the positive x direction  
Y max = 37; //measured in the positive y direction  
Gantry Height = 82mm; //the lowest point on the rails in which the extruder assembly rides to the print bed when the nozzle is at height Z=0  
  
Extruder 1  
Nozzle size = 0.4mm; Compatible material diameter = 1.75 mm;  
  
### [The Start and End G-codes](StartAndEndG-code.txt)  
  
### Specify Material  
Filament Material = Generic PLA;  
Filament Diameter = 1.7mm;  
Default Printing Temperature = 200 Degree Celsius; //use the mid value of range  
Default Build Plate Temperature = 70 Degree Celsius; //per online recommendation  
Retraction Distance = 6.5mm; //Generic Default  
Retraction Speed = 25mm/s; //Generic Default  
  
### Level Bed  
  
### Calibrate XYZ Steps per mm ([reference](https://www.youtube.com/watch?v=W4CsD5lRvHY&feature=emb_logo))  
  
Default steps/mm  
X&Y = 80; Z = 400; E = 95.8;  
  
X axis  
[Y = 0, Z = 3]; intended travel = 250mm; actual = 250.2mm;  
[Y = 150, Z = 3]; intended travel = 250mm; actual = 250.4mm; <- Scale Model by .99840  
[Y = 300, Z = 3]; intended travel = 250mm; actual = 250.4mm;  
  
Y axis  
[X = 0, Z = 3]; intended travel = 300mm; actual = 297.5mm;  
[X = 125, Z = 3]; intended travel = 300mm; actual = 299mm; <- Scale Model by 1.00334  
[X = 250, Z = 3]; intended travel = 300mm; actual = 298mm;  
  
Z axis  
[X = 0, Y = 0]; intended travel = 297mm; actual = 296.2mm;  
[X = 0, Y = 300]; intended travel = 297mm; actual = 296.5mm ;  
[X = 125, Y = 150]; intended travel = 297mm; actual = 297mm; <- Average of all measurements  
[X = 250, Y = 0]; intended travel = 297mm; actual = 296.2mm;  
[X = 250, Y = 300]; intended travel = 297mm; actual = 296.25mm;  
  
existing value * desired value / actual value = corrected value  
X = 80 * .99840 = 79.872;  
Y = 80 * 1.00334 = 80.267;  
Z = 400 * 1.0019 = 400.76;  

Use [these G-codes](CalibrateXYZStepsPerMm.gcode) to save the corrected values.

### Calibrate Extruder Steps per mm (E) ([reference](https://mattshub.com/blog/2017/04/19/extruder-calibration))
existing value * desired value / actual value = corrected value
1st Run: 95.8 * 100 / 54 = 177.4;
2nd Run: 177.4 * 100 / 104 = 170.577;

Use [these G-codes](CalibrateExtruderStepsPerMm.gcode) to calibrate and save the corrected values.

### Set Constants
These constant parameter(s) are chosen and set for production print:
Layer height = 0.1mm; //set equal to XY resolution
Load default cura profile "Fine", which has a layer height of 0.1mm.




## Part 2: Multi-Parameter Optimization

Iterate in the following order to home in on the best values. Skip sections which will have been well optimized.

int outerIteration{0};  // iteration number 0, 1, 2, 3... etc.
### Tune Print Speed ([reference](https://all3dp.com/2/3d-printing-speed-optimal-settings/) | [reference](https://www.thingiverse.com/thing:1586548))
if (outerIteration == 0) // if it's the first time running this subsection
{
    Print Speed = 50;
}
else
{
	ChangeAtZ
	Layer No = 1  | Extruder 1 Temp = 195 
	Layer No = 48 | Extruder 1 Temp = 200
	Layer No = 98 | Extruder 1 Temp = 205
	... (10 layers total)
	Alter print speed only at 12.5 mm
}

### Tune First Layer 
[reference](https://www.youtube.com/watch?v=pAFDEn3wGYo)
Initial Layer Speed = 20mm/s
Combing Mode = Not in Skin
Max Comb Distance With No Retract = 15mm
Z Offset = -0.2mm ([reference](https://all3dp.com/2/cura-z-offset-simply-explained/))

### Tune Hotend Temperature ([reference](https://e3d-online.dozuki.com/Guide/Calibrating+Printing+temperature/91))
Use the [Smart compact temperature calibration Tower](https://www.thingiverse.com/thing:2729076)
In Preferences, disable "Ensure models are kept apart" and "Automatically drop models to the build plate".
Scale the models down to save costs. Stack them on top of each other. Use "Extensions" -> "Post Processing" -> "ChangeAtZ" to set the temperatures.
Infill = 15%
Support = No

(start tuning acceleration and jerk control)
Print Acceleration = 1500 mm/s^2 
Print Jerk = 20 mm/s

[Save the Cura project](CFFFP_SmartTemperatureTower_195-230.3mf).
Slice and print.


Optimal hotend temperature = 217 Celsius.

Adjust retraction speed and distance.

Tune PID ([reference](https://www.3dhubs.com/talk/t/howto-calibrate-tune-and-fine-tune-your-printer-and-filament/5695))






### Calibrate Flow Rate 
https://www.thingiverse.com/thing:3397997
https://e3d-online.dozuki.com/Guide/Flow+rate+(Extrusion+multiplier)+calibration+guide./89
Line Width = 0.48 (1.2 * nozzle diameter for die swell. Use this to calibrate flow rate)

Existing flow rate * Desired wall thickness / actual wall thickness = corrected flow rate
1th Run
41.18 * .96 / .87 = 45.44

Flow rate = 40.34 (perfect for a layer height of 0.2mm)





============================
== Optimize Acceleration Control and Jerk Control ==
============================



============================
== All in one 3D printer test micro ==
============================
https://www.thingiverse.com/thing:2975429
small tip : try printing this with thing walls enabled in your slicer so you can get better tolerance results!

Rafts =
No

Supports =
No

Resolution =
0.05-0.2 lh

Infill =
30%



================================
== Other Parameters Optimized ==
================================
Layer Height = 0.1mm (vertical resolution)
Line Width = 0.48 (1.2 * nozzle diameter)
Print Speed = 50 mm/s
Travel Speed = 200 mm/s
Printing Temperature Initial Layer = Printing Temperature * 1.05
Build Plate Temperature Iniatil Layer = Build Plate Temperature * 1.05


Retraction Distance = 6 mm
Retraction Speed = 25 mm/s
Infill Pattern = Gyroid infill
Gradual infill steps