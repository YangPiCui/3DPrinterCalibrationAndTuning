# Doogell Vega Calibration and Tuning
Bought 2nd hand for $500.  
It has imported stepper motors and linear rails.  
Greased rails. Cleaned belt and belt housing.  
Replaced bed cover with tempered sanded-surface glass.  
Pressed printer frame against wall to steady the former.  
Touch screen is inaccurate to the touch. One cannot change firmware values with it.  
Use Cura 4.6.1 as the slicer software.  
  
In a multi-parameter optimization, if one parameter changes, multiple other parameters have to change, too. For example, if we change the layer height, the print speed and the flow rate both have to change (in an unpredictable manner) to ensure the same print accuracy. Fixing as many parameters as possible upfront would simply the optimization.

## Section A: Calibrate and Optimize Independent Parameters
### Level the Bed  
First level the bed to the hotend with the paper method. Make sure both the hotend and the bed are at printing temperatures. Use default values for this.  
Next, level the whole printer with a bubble leveler placed on the bed.  


### Specify Printer Parameters
CoreXY structure; 
X/Y resolution = 0.1mm;  
Z resolution = 0.04mm;    
> Max hotend temperature = 260;
> Max bed temperature = 70;  

> X direction = ↓; X range = 0-250;  
> Y direction = →, Y range = 0-293; //Belt starts to slip at 294  
> Z direction = up, Z range = 0-175; //with glass bed. Default 300.
> Rectangular; Heated bed; G-code flavor = RepRap;  
  
Printhead ([how these values are defined](https://community.ultimaker.com/topic/18484-printhead-settings/))  
> X min = -29; //measured in the negative x direction  
> Y min = -37; //measured in the negative y direction  
> X max = 60; //measured in the positive x direction  
> Y max = 37; //measured in the positive y direction  
> Gantry Height = 82mm; //the lowest point on the rails in which the extruder assembly rides to the print bed when the nozzle is at height Z=0  
  
Extruder 1  
> Nozzle size = 0.3mm; //default 0.4mm  
> Compatible material diameter = 1.75 mm;  
> Nozzle Flat = 1.2mm.  
    
### Specify Material  
>Filament Material = Generic PLA;  
>Filament Diameter = 1.7mm;  
   
   
### Calibrate XYZ Steps/mm and Max Speed ([reference](https://www.youtube.com/watch?v=W4CsD5lRvHY&feature=emb_logo))  
Make sure the hotend is not obstructed in any direction.  
Default steps/mm  (Machine LCD screen under "Advanced Settings")
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
> X = 80 * .99840 = 79.872;  
> Y = 80 * 1.00334 = 80.267;  
> Z = 400 * 1.0019 = 400.76;  
  
> X/Y Max Speed = 300mm/s; //approximation  
> Z Max Speed =  12.5mm/s; //approximation  

Since Doogell Vega has no console, use [these G-codes](CalibrateXYZStepsAndMaxSpeed) to save the corrected values.   

### Calibrate Extruder Steps/mm (E) and Max Speed ([reference](https://mattshub.com/blog/2017/04/19/extruder-calibration))  
Calibrate when filament diameter changes.  
Remove the hot end.  
Use [these G-codes](CalibrateExtruderStepsAndMaxSpeed) to calibrate and save the corrected values.  
> E Max Speed = 28 mm/s;  

corrected value = existing value * desired value / actual value
> E steps/mm = 96.67 * 200 / 200.5 = 96.5;  


### [The Printer's Start and End G-codes in Cura](StartAndEndG-code.txt)  


### Set Print Parameters 
Load default cura profile "Fine", which has a layer height of 0.1mm.  
Choose these constant parameter(s) for production print:  
> Layer height = 0.16; //A multiple of 0.04mm and should be less than 80% of nozzle diameter. [stepper motor magic number](https://www.youtube.com/watch?v=WIkT8asT90A).  [Which layer height gives you the strongest 3D prints](https://www.youtube.com/watch?v=fbSQvJJjw2Q&t=644s).  
> Line Width = 0.48; //Minimum Line Width = Nozzle Size + Layer Height;  Maximum Line Width = Nozzle Flat Size + Layer Height;  [understand line width](https://dyzedesign.com/2018/07/3d-print-speed-calculation-find-optimal-speed/#:~:text=A%20general%20rule%20of%20thumb,bigger%20nozzles%20and%20layer%20height.)  
> Print Speed = 90mm/s; //[3D Printing Speed Calculator](https://dyzedesign.com/3d-printing-speed-calculator/). Set to slightly less than max.  
> Top/Bottom Pattern = Bottom Pattern Initial Layer = Zig Zag;  
> Infill Pattern = Gyroid;  //[increased strength for the lowest weight.](https://support.ultimaker.com/hc/en-us/articles/360012607079-Infill-settings) [Testing 3D printed infill pattern.](https://www.youtube.com/watch?v=upELI0HmzHc)
> Optimize Wall Printing Order = True;  
> Print Thin Walls = True;   
> Z Seam Alignment = Random;  


## Section B: Optimize Inter-dependent Parameters Iteratively
### Acceleration and Jerk Control ([reference](https://all3dp.com/2/3d-printing-speed-optimal-settings/) | [reference](https://www.thingiverse.com/thing:1586548) | [Printing at 300mm/s](https://dyzedesign.com/2016/10/printing-300-mm-s-part-1-basics-hardware/) | [Motion Profile](https://www.controleng.ca/servosoft/SSHelp1033/source/MotionProfile.htm) | [reference](https://www.reddit.com/r/3Dprinting/comments/99rhah/what_is_jerk_really_measuring/))  
The Cura settings alone don't affect how this printer prints. Put these values in the Start D-code using the commands M201, M202, and M566. See [The Printer's Start and End G-codes in Cura](StartAndEndG-code.txt) for the tuned values.


### Cooling
> Enable Print Cooling = True;  
> Fan Speed = 40;   
  

### Hotend PID ([reference](https://reprap.org/wiki/PID_Tuning))
The printer can't display PID auto tuning results on the LCD touch screen. Neither does it log to SD card. Integrate [these G-codes](TuneAndLogTemperaturePID.gcode) into the Start G-code in Cura to set and save temperature PID manually. 
[Print 0]  
> Default PID is good: P = 10; I = 2.5; D = 100; (Machine LCD screen under "Advanced Settings")  

### Hotend Temperature - 3D Print Here! ([reference](https://e3d-online.dozuki.com/Guide/Calibrating+Printing+temperature/91))(https://matterhackers.dozuki.com/Guide/PID+Tuning/6)) | [reference](https://reprap.org/wiki/PID_Tuning) | [reference]([https://reprap.org/wiki/G-code#M928:_Start_SD_logging](https://reprap.org/wiki/G-code#M928:_Start_SD_logging))) 

Stack the [Smart compact temperature calibration Towers](https://www.thingiverse.com/thing:2729076)   on top of each other [in Cura](CalibrationObjects/TemperatureTower.3mf). Make sure you import the models only (without importing profiles)! Use "Extensions" -> "Post Processing" -> "ChangeAtZ" to set the temperatures.  (1.4mm, 11.4mm, 21.4mm ...)
  
Infill = 15%;  
Support = No;  
Build Plate Adhesion = Skirt;  
> Printing Temperature = 200 Celsius;  
> Build Plate Temperature = 60;  //[reference](https://all3dp.com/2/the-best-pla-print-temperature-how-to-achieve-it/)  | [Correct elephant foot and print edge bending.]  

    
### Retraction Values (Minimize Stringing) - 3D Print Here! ([reference](https://all3dp.com/2/3d-print-stringing-easy-ways-to-prevent-it/) | [reference](https://www.thingiverse.com/thing:2219103))
[StringTest.stl](CalibrationObjects/StringTest.stl)  
Wall Line Count = 4; //default 1  
Top Layers = Bottom Layers = 4; //default 4  
Infill Density = 100;  
Support = No;  
Build Plate Adhesion = skirt;  
> Retract Before Outer Wall = True;  
> Retraction Distance = 2mm;  
> Retraction Speed = 30mm/s;  
> Combing Mode = Not in Skin;  
> Max Comb Distance With No Retract = 15mm;  
> Z Hop When Retracted = False;  

  
### Flow Rate (Extruder Multiple) - 3D Print Here!  ([reference](https://e3d-online.dozuki.com/Guide/Flow+rate+%28Extrusion+multiplier%29+calibration+guide./89))  
[FlowRateCalibration.3mf](CalibrationObjects/FlowRateCalibration.3mf) Make sure you import the models only (without importing profiles)!  
Wall Line Count = 2; //default 1  
Top Layers = Bottom Layers = 0; //default 4  
Infill Density = 0;  
Build Plate Adhesion Type = Brim;  
  
Corrected Flow Rate = Existing flow rate * Desired wall thickness / actual wall thickness
> Flow = 95;
(https://all3dp.com/1/common-3d-printing-problems-troubleshooting-3d-printer-issues/)  

### Horizontal Expansion - 3D Print Here! ([reference](https://www.youtube.com/watch?v=UUelLZvDelU) | [reference](https://bradshacks.com/3d-printing-tolerancing/))
[HorizontalExpansionCalibration.3mf](CalibrationObjects/HorizontalExpansionCalibration.3mf) Import model only!  
> Wall Line Count = Top Layers = Bottom Layers = 6; //[3-4 for good strength. Max strength with 5-6 lines and 20-30% infill.](https://www.youtube.com/watch?v=sAZpnlzCwiU)  
> Infill = 30%;  
> Connect Infill Lines;  
> Randomize Infill Start;  
> Support = None;  
> Build Plate Adhesion = Skirt;  
> Skirt Line Count = 2;  
> Skirt Distance = 5mm;  
> Skirt Minimum Length = 50mm;  
> Horizontal Expansion = Initial Layer Horizontal Expansion = -0.05; //
> Hole Horizontal Expansion = 0.1; //  


### Initial Layer
> Initial Layer Height = 0.16; // >=Layer Height, <=80% of nozzle size, multiple of 0.04mm. 
> Z Offset = -0.0mm; //[cura z offset simply explained](https://all3dp.com/2/cura-z-offset-simply-explained/) 
> Initial Layer Speed = 20mm/s; //[Tune First Layer.](https://www.youtube.com/watch?v=pAFDEn3wGYo)  
> Bottom Pattern Initial Layer = Concentric;  
> Initial Layer Flow = 100; //this is scaled from the Flow value  


### Ironing
> Enable Ironing = False;  
> Iron Only Highest Layer = False;  
> Ironing Pattern = Concentric;  
> Ironing Line Spacing = 0.24; //1/2 of line width  


### Other Test Parts
[20x20mm Calibration Cube](https://www.thingiverse.com/thing:1278865)  
[Tolerance Test](https://www.thingiverse.com/thing:2318105)
[3DBenchy](https://www.thingiverse.com/thing:763622)
[All in One 3D Printer Test](https://www.thingiverse.com/thing:2975429)  


### Other settings
> Maximum Resolution = 0.001;  
> Infill Travel Optimization = On;  
> Avoid Supports When Travelling = True;
> Slicing Tolerance = Inclusive;  
> Use Adaptive Layers = True; //set to false by default.
> Adaptive Layers Maximum Variation = 0.08; //half of line height  
> Adaptive Layers Variation Setp Size = 0.04;  
> Adaptive Layers Topography Size = 0.16; //same as line height
   
    
