

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
X/Y resolution = 0.1mm;  X/Y speed = 35mm/s;
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
>Filament Material = Generic PLA;  //Final.
>Filament Diameter = 1.7mm;  //Final.

Default Printing Temperature = 200 Degree Celsius; //use the mid value of range  
Default Build Plate Temperature = 60 Degree Celsius; //[per online recommendation](https://all3dp.com/2/the-best-pla-print-temperature-how-to-achieve-it/)  

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
> X = 80 * .99840 = 79.872;  
> Y = 80 * 1.00334 = 80.267;  
> Z = 400 * 1.0019 = 400.76;  
  
Doogell Vega has no accessible console. Use [these G-codes](CalibrateXYZStepsPerMm.gcode) to save the corrected values.  

### Calibrate Extruder Steps per mm (E) ([reference](https://mattshub.com/blog/2017/04/19/extruder-calibration))  
Ideally, one should remove the hot end for this.  
existing value * desired value / actual value = corrected value  
1st Run: 95.8 * 100 / 54 = 177.4;  
> 2nd Run: 177.4 * 100 / 104 = 170.577;  //Final.
  
Use [these G-codes](CalibrateExtruderStepsPerMm.gcode) to calibrate and save the corrected values.  
  
### Set Constants  
Load default cura profile "Fine", which has a layer height of 0.1mm.  
These constant parameter(s) are chosen and set for production print:  
> Layer height = 0.2; //A multiple of 0.04mm and should be less than 80% of nozzle diameter. See [stepper motor magic number](https://www.youtube.com/watch?v=WIkT8asT90A).
> Infill Pattern = Gyroid;  //[increased strength for the lowest weight.](https://support.ultimaker.com/hc/en-us/articles/360012607079-Infill-settings)  
> Initial Layer Speed = 20mm/s; //[Tune First Layer.](https://www.youtube.com/watch?v=pAFDEn3wGYo)  
> Combing Mode = Not in Skin;  
> Max Comb Distance With No Retract = 15mm;  
> Optimize Wall Printing Order = True;  
> Print Thin Walls = True;  
  
## Part 2: Multi-Parameter Optimization
Iterate in the following order to tune in on the best values. Skip tuning sections which will have been well optimized.  



  
#### Tune Print Speed, Acceleration and Jerk Control ([reference](https://all3dp.com/2/3d-printing-speed-optimal-settings/) | [reference](https://www.thingiverse.com/thing:1586548))  
Achieve the highest speed without sacrificing quality.
> Print Speed = 35; //This is the printer's max speed as manually measured. It's already very slow.  
> 
Iteration 0  
Print Acceleration = 70mm/s^2; //Achieves full speed in 0.5 seconds. 
Travel Acceleration = 70mm/s^2;  
Print Jerk = 1mm/s;  
Travel jerk = 1mm/s;  

#### Tune Build Plate Adhesion and First Layers

Iteration 0  
Default Build Plate Temperature = 75;  [Correct elephant foot and print edge bending.](https://all3dp.com/1/common-3d-printing-problems-troubleshooting-3d-printer-issues/)
Z Offset = -0.1mm; //[cura z offset simply explained](https://all3dp.com/2/cura-z-offset-simply-explained/)  


#### Tune Hotend PID ([reference](https://reprap.org/wiki/PID_Tuning))
The printer can't display PID auto tuning results on the LCD touch screen. Neither does it log to SD card. Integrate [these G-codes](TuneAndLogTemperaturePID.gcode) into the Start G-code in Cura to set and save temperature PID manually. 
Default PID: P = 10; I = 2.5; D = 100; (Machine LCD screen under "Advanced Settings")  
Iteration 0:  
Default PID: P = 10.5; I = 2.5; D = 105;  

#### Tune Hotend Temperature ([reference](https://e3d-online.dozuki.com/Guide/Calibrating+Printing+temperature/91))(https://matterhackers.dozuki.com/Guide/PID+Tuning/6)) | [reference](https://reprap.org/wiki/PID_Tuning) | [reference]([https://reprap.org/wiki/G-code#M928:_Start_SD_logging](https://reprap.org/wiki/G-code#M928:_Start_SD_logging))) 

Stack the [Smart compact temperature calibration Towers](https://www.thingiverse.com/thing:2729076)   on top of each other in Cura. Use "Extensions" -> "Post Processing" -> "ChangeAtZ" to set the temperatures.  
  
Iteration 0:  
Printing Temperature = 200 Celsius;  
Infill = 15%;  
Flow Rate = 40.34; //from earlier calibration  
Initial Layer Flow = 40.34;  
Enable Retraction = false; //we will tune retraction later
Support = No;  
[Save the Cura project](CFFFP_SmartTemperatureTower_195-230.3mf), slice and print!  
  


#### Calibrate Flow Rate (Extruder Multiple)  ([reference](https://e3d-online.dozuki.com/Guide/Flow+rate+%28Extrusion+multiplier%29+calibration+guide./89) | [understand line width](https://dyzedesign.com/2018/07/3d-print-speed-calculation-find-optimal-speed/#:~:text=A%20general%20rule%20of%20thumb,bigger%20nozzles%20and%20layer%20height.))  
Minimum Line Width = Nozzle Size + Layer Height;  
Maximum Line Width = Nozzle Flat Size + Layer Height;  
Line Width = 0.6;  
Infill Density = 0;  
  
Existing flow rate * Desired wall thickness / actual wall thickness = corrected flow rate
Iteration 0: 




#### Tune Retraction to Minimize Stringing ([reference](https://all3dp.com/2/3d-print-stringing-easy-ways-to-prevent-it/))
Only use retraction when needed.  This saves time and eases the load on the Z axis stepper motor.
Iteration :  
Retraction Distance = 6.5mm;  
Retraction Speed = 25mm/s; //Same as Print Speed  
Z Hop When Retracted = true;  
Z Hop Only Over Printed Parts = true;  
Z Hop Height = 0.6mm; //3 times the layer height <= height <= 1mm;

#### Print "All in One 3D Printer Test Micro" ([reference](https://www.thingiverse.com/thing:2975429))  
Supports = No; 
>Wall Line Count = 4; //[3-4 for good strength. Max strength with 5-6 lines and 20-30% infill.](https://www.youtube.com/watch?v=sAZpnlzCwiU)  
>Infill = 15%;  
   
    
