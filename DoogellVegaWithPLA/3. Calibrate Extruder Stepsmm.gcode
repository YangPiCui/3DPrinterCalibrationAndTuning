;Start of G-code
;Sliced at: {day} {date} {time}
;Basic settings: Layer height: {layer_height} Walls: {wall_thickness} Fill: {fill_density}
;Print time: {print_time}
;Filament used: {filament_amount}m {filament_weight}g
;Filament cost: {filament_cost}


M92 E170.577 ;set extruder steps/mm
M500         ;save calibrated extruder steps/mm

M17        ;enable step motor idle hold (for glass bed)
M18 S0     ;disable stepper motor idle timeout
M109 S200  ;heat hot end to this temperature and wait
G21        ;metric values
G90        ;absolute positioning
M82        ;absolute extrusion mode
M107       ;start with the fan off
G28		   ;performe homing routine

G92 E0          ;reset the extruder position to 0mm
G0 Z30          ;move the platform down 30mm
G1 F50          ;Set feed rate to 50mm/minute. Ensure that the resistance of the plastic further down in the hotend does not affect how much is fed in by the stepper motor
G1 E100         ;eject 100mm of material
G92 E0


;End of G-code
M104 S0                                ;turn off heating the extruder
M140 S0                                ;turn off heating the bed
G28 X0 Y0                              ;move X/Y to min endstops, so the head is out of the way
M84                                    ;steppers off
M300 S300 P1000 ; Play a 300Hz beep sound for 1000 milliseconds
M117 Done! ;Put printing message on LCD screen

;{profile_string}

