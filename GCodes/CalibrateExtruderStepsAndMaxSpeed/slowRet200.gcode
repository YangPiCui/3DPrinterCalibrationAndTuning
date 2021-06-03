G21        ;metric values
G90        ;absolute positioning
M82        ;absolute extrusion mode
M107       ;start with the fan off

G28		   ;performe homing routine
G0 Z50            ;move the platform down 50mm

G1 F300         ;set a slower feedrate

G92 E0           ;reset the extruder position to 0mm
G1 E-200          ;retract 200mm of material
G92 E0           ;reset the extruder position to 0mm