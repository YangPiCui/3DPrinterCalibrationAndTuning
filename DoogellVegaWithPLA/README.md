

# Doogell Vega Calibration and Tuning

Bought 2nd hand for $500.   Imported stepper motors and linear rails.
Greased rails. Cleaned belt and belt housing.  
Replaced bed cover with tempered sanded-surface glass.  
Pressed printer frame against wall to steady the former.  
Touch screen is inaccurate to the touch. One cannot change firmware values with it.  
Use Cura 4.6.1 as the slicer software.  
  
In a multi-parameter optimization, if one parameter changes, multiple other parameters have to change, too. For example, if we change the layer height, the print speed and the flow rate both have to change (in an unpredictable manner) to ensure the same print accuracy. Fixing as many parameters as possible upfront would simply the optimization.

## Part 0: Optimize Independent Parameters

### 3D Printer Specification  
CoreXY structure; Linear XY Rails;  
X/Y resolution = 0.1mm;  
Z resolution = ?; //<=0.1 mm  

>X direction = ↓; X range = 0-250;  
Y direction = →, Y range = 0-293; //Belt starts to slip at 294  
Z direction = up, Z range = 0-300;  
Rectangular; Heated bed; G-code flavor = RepRap;  
  
Printhead ([how these values are defined](https://community.ultimaker.com/topic/18484-printhead-settings/))  
>X min = -29; //measured in the negative x direction  
Y min = -37; //measured in the negative y direction  
X max = 60; //measured in the positive x direction  
Y max = 37; //measured in the positive y direction  
Gantry Height = 82mm; //the lowest point on the rails in which the extruder assembly rides to the print bed when the nozzle is at height Z=0  
  
Extruder 1  
>Nozzle size = 0.4mm; Compatible material diameter = 1.75 mm;  
  
### [The Start and End G-codes](StartAndEndG-code.txt)  
  
### Specify Material  
>Filament Material = Generic PLA;  
>Filament Diameter = 1.7mm;  

Default Printing Temperature = 200 Degree Celsius; //use the mid value of range  
Default Build Plate Temperature = 70 Degree Celsius; //per online recommendation  
Retraction Distance = 6.5mm; //Generic Default  
Retraction Speed = 25mm/s; //Generic Default  
  
### Level Bed  
  
### Calibrate XYZ Steps per mm ([reference](https://www.youtube.com/watch?v=W4CsD5lRvHY&feature=emb_logo))  
  
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
X = 80 * .99840 = 79.872;  
Y = 80 * 1.00334 = 80.267;  
Z = 400 * 1.0019 = 400.76;  
  
Doogell Vega has no accessible console. Use [these G-codes](CalibrateXYZStepsPerMm.gcode) to save the corrected values.  

### Calibrate Extruder Steps per mm (E) ([reference](https://mattshub.com/blog/2017/04/19/extruder-calibration))  
existing value * desired value / actual value = corrected value  
1st Run: 95.8 * 100 / 54 = 177.4;  
2nd Run: 177.4 * 100 / 104 = 170.577;  
  
Use [these G-codes](CalibrateExtruderStepsPerMm.gcode) to calibrate and save the corrected values.  
  
### Set Constants  
These constant parameter(s) are chosen and set for production print:  
Layer height = 0.1mm; //set equal to XY resolution  
Load default cura profile "Fine", which has a layer height of 0.1mm.  
Optimize Wall Printing Order = True;  //[reference](https://www.youtube.com/watch?v=sAZpnlzCwiU)  
Print Thin Walls = True;  
Infill Pattern = Gyroid;  //increased strength for the lowest weight. [reference](https://support.ultimaker.com/hc/en-us/articles/360012607079-Infill-settings)  
  
## Part 2: Multi-Parameter Optimization
Iterate in the following order to tune in on the best values. Skip tuning sections which will have been well optimized.  
#### Tune First Layer ([reference](https://www.youtube.com/watch?v=pAFDEn3wGYo))
Iteration 0:  
Initial Layer Speed = 20mm/s; //final  
Combing Mode = Not in Skin; //final   
Max Comb Distance With No Retract = 15mm; //final  
Z Offset = -0.2mm; //[reference](https://all3dp.com/2/cura-z-offset-simply-explained/) 
  
Iteration 1: 
Z Offset = -0.1mm; //final  
  
#### Tune Print Speed ([reference](https://all3dp.com/2/3d-printing-speed-optimal-settings/) | [reference](https://www.thingiverse.com/thing:1586548))  
Achieve the highest possible speed with intended quality.

Iteration 0:  
Print Speed = 50; Print Acceleration = 1500mm/s^2; Print Jerk = 20mm/s;  
Iteration 1:  
Print Speed = 40; Print Acceleration = 750mm/s^2; Print Jerk = 10mm/s;  
Iteration 2:  
Print Speed = 60; Print Acceleration = 700mm/s^2; Travel Acceleration = 1400 mm/s^2; Print Jerk = 5mm/s;  Travel jerk = 10mm/s;  
Iteration 3:  
Print Speed = 60; Print Acceleration = 350mm/s^2; Travel Acceleration = 350 mm/s^2; Print Jerk = 2.5mm/s;  Travel jerk = 2.5mm/s;  
  
#### Tune Hotend PID ([reference](https://reprap.org/wiki/PID_Tuning))
The printer can't display PID auto tuning results on the LCD touch screen. Neither does it log to SD card. Integrate [these G-codes](TuneAndLogTemperaturePID.gcode) into the Start G-code in Cura to set and save temperature PID manually. 
Iteration 0:  
Default PID: P = 10; I = 2.5; D = 100; (Machine LCD screen under "Advanced Settings")  
Iteration 2:  
Default PID: P = 11; I = 2.5; D = 100;  
Iteration 3:  
Default PID: P = 11; I = 2.75; D = 100;  

#### Tune Hotend Temperature ([reference](https://e3d-online.dozuki.com/Guide/Calibrating+Printing+temperature/91))(https://matterhackers.dozuki.com/Guide/PID+Tuning/6)) | [reference](https://reprap.org/wiki/PID_Tuning) | [reference]([https://reprap.org/wiki/G-code#M928:_Start_SD_logging](https://reprap.org/wiki/G-code#M928:_Start_SD_logging))) 

Stack the [Smart compact temperature calibration Towers](https://www.thingiverse.com/thing:2729076)   on top of each other in Cura. Use "Extensions" -> "Post Processing" -> "ChangeAtZ" to set the temperatures.  
  
Iteration 0:  
Printing Temperature = 200;  
Infill = 15%;  
Flow Rate = 45.44; //I have previously calibrated the flow rate at 217 Celsius. 
Support = No;  
 [Save the Cura project](CFFFP_SmartTemperatureTower_195-230.3mf);  
Slice and 3D-print!  
  
Iteration 2: 
Printing Temperature = 215 Celsius;  

#### Calibrate Flow Rate (Extruder Multiple)  ([reference](https://e3d-online.dozuki.com/Guide/Flow+rate+%28Extrusion+multiplier%29+calibration+guide./89) | [reference](https://www.thingiverse.com/thing:3397997))  
Pick the calibration model which matches the nozzle size.
Line Width = 0.4;  //same as nozzle size
Infill Density = 0;

previous optimization: Flow rate = 40.34; //perfect for speed = 50mm/s and layer height = 0.2mm  
Existing flow rate * Desired wall thickness / actual wall thickness = corrected flow rate
Iteration 0: 45.44 * .8 /  =



  
#### Test with "All in One 3D Printer Test Micro" ([reference](https://www.thingiverse.com/thing:2975429))  
Rafts = No; Supports = No; Infill = 30%;  


#### Rectraction
  
### Optimize Other Parameters
Line Width = .48; //(1.2 * nozzle diameter for die swell. Use this to calibrate flow rate)
Wall Line Count = 4; //3-4 for good strength. Max strength with 5-6 lines and 20-30% infill. [reference](https://www.youtube.com/watch?v=sAZpnlzCwiU)  
Infill = 15%;  
