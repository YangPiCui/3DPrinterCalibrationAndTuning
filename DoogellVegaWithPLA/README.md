
# Doogell Vega Calibration and Tuning
Bought 2nd hand for $500. 
Greased rails. Cleaned belt and belt housing. 
Replaced bed cover with tempered sanded-surface glass.
Pressed printer frame against wall to steady the former.
Use Cura 4.6.1 as the slicer software.

### 3D Printer Specification
CoreXY structure, Linear XY Rails
X/Y resolution: 0.1mm
Z resolution: (<=0.1 mm)

X direction: ↓, X range: 0-250 
Y direction: →, Y range: 0-293 (Belt starts to slip at 294)
Z direction: up, Z range: 0-300
Rectangular, Heated bed, G-code flavor: RepRap

Printhead: ([value definition](https://community.ultimaker.com/topic/18484-printhead-settings/)) 
X min: -37 (measured in the negative x direction)
Y min -107 (measured in the negative y direction)
X max: 37 (measured in the positive x direction)
Y max: 37 (measured in the positive y direction)
Gantry Height: 80mm (the lowest point on the rails in which the extruder assembly rides to the print bed when the nozzle is at height Z=0)

Extruder 1:
Nozzle size: 0.4mm, Compatible material diameter: 1.75 mm

### [The Start and End G-code](StartAndEndG-code.txt)

### Material Used
Filament Material: Generic PLA
Filament Diameter: 1.7mm 
Default Printing Temperature: 217 Degree Celsius (after rough temperature optimization)
Default Build Plate Temperature: 70 Degree Celsius (per online recommendation)
Retraction Distance: 6 mm (after rough observation)
Retraction Speed: 25 mm/s (from Ender 3 setting)


## Single-Parameter Optimization

Level bed first.

### 1. Calibrate XYZ Steps per mm 
Default steps/mm:
X&Y 80, Z 400, E 95.8

X axis: 
[Y = 0, Z = 3], intended travel: 250mm, actual: 250.2mm
[Y = 150, Z = 3], intended travel: 250mm, actual: 250.4mm <- Scale Model by .99840
[Y = 300, Z = 3], intended travel: 250mm, actual: 250.4mm

Y axis: 
[X = 0, Z = 3], intended travel: 300mm, actual: 297.5mm
[X = 125, Z = 3], intended travel: 300mm, actual: 299mm <- Scale Model by 1.00334
[X = 250, Z = 3], intended travel: 300mm, actual: 298mm

Z axis: Scale Model by 1.0019
[X = 0, Y = 0], intended travel: 297mm, actual: 296.2mm
[X = 0, Y = 300], intended travel: 297mm, actual: 296.5mm 
[X = 125, Y = 150], intended travel: 297mm, actual: 297mm <- Average of all measurements
[X = 250, Y = 0], intended travel: 297mm, actual: 296.2mm
[X = 250, Y = 300], intended travel: 297mm, actual: 296.25mm

existing value * desired value / actual value = corrected value
X: 80 * .99840 = 79.872
Y: 80 * 1.00334 = 80.267
Z: 400 * 1.0019 = 400.76

### 2. Calibrate Extruder Steps per mm (E)
existing value * desired value / actual value = corrected value
1st Run: 95.8 * 100 / 54 = 177.4
2nd Run: 177.4 * 100 / 104 = 170.577 



## Multi-Parameter Optimization
Choose / set constant parameters:
Layer Height: 0.1mm (equal to XY resolution)


### 5. Optimize Hotend Temperature 
https://e3d-online.dozuki.com/Guide/Calibrating+Printing+temperature/91

ChangeAtZ
Layer No: 1  | Extruder 1 Temp: 195 
Layer No: 48 | Extruder 1 Temp: 200
Layer No: 98 | Extruder 1 Temp: 205
... (10 layers total)

Hotend: 217 Celsius
Bed: 70 Celsius (recommended temperature)


============================
== 6. Calibrate Print Speed ==
============================
https://all3dp.com/2/3d-printing-speed-optimal-settings/
https://www.thingiverse.com/thing:1586548
Print Speed: 50 mm/s 

ChangeAtZ
Layer No: 1  | Extruder 1 Temp: 195 
Layer No: 48 | Extruder 1 Temp: 200
Layer No: 98 | Extruder 1 Temp: 205
... (10 layers total)
Alter print speed only at 12.5 mm




============================
== 5. Calibrate Flow Rate ==
============================
https://www.thingiverse.com/thing:3397997
https://e3d-online.dozuki.com/Guide/Flow+rate+(Extrusion+multiplier)+calibration+guide./89
Line Width: 0.48 (1.2 * nozzle diameter for die swell. Use this to calibrate flow rate)

Existing flow rate * Desired wall thickness / actual wall thickness = corrected flow rate:
.2 layer height: 40.34
1th Run: 41.18 * .96 / .87 = 45.44






============================
== Optimize Acceleration Control and Jerk Control ==
============================



============================
== All in one 3D printer test micro ==
============================
https://www.thingiverse.com/thing:2975429
small tip : try printing this with thing walls enabled in your slicer so you can get better tolerance results!

Rafts:
No

Supports:
No

Resolution:
0.05-0.2 lh

Infill:
30%



================================
== Other Parameters Optimized ==
================================
Layer Height: 0.1mm (vertical resolution)
Line Width: 0.48 (1.2 * nozzle diameter)
Print Speed: 50 mm/s
Travel Speed: 200 mm/s
Printing Temperature Initial Layer: Printing Temperature * 1.05
Build Plate Temperature Iniatil Layer: Build Plate Temperature * 1.05


Retraction Distance: 6 mm
Retraction Speed: 25 mm/s
Infill Pattern: Gyroid infill
Gradual infill steps