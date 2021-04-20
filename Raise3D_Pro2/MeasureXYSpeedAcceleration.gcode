G21        ;metric values
G90        ;absolute positioning
M82        ;absolute extrusion mode
M107       ;start with the fan off

M140 S0
M105
M190 S0
M104 S0
M105
M109 S0

G28		   ;performe homing routine
G0 Z50            ;move the platform down 50mm
M203 X99999 Y99999   ; set max speed

; *** 0 ***
M204 P22 T22 R3000                            ;Set starting print, travel and retract accelaration
M201 X30 Y30 Z50 E10000                   ;Set max print and retract acceleration in mm/s^2. 
M205 X4 Y4 Z0.05 E5                           ;Sets the max speed at which direction changes occur. 0 for infinite jerk. 
M500                                          ;save 

G1 X290            ;move to the X=250 position on the bed 
G1 X0              ;move to the X=0 position on the bed at max speed            
G1 Y290             
G1 Y0   

; *** 1 ***
M204 P10000 T10000 R3000                            ;Set starting print, travel and retract accelaration
M201 X60 Y60 Z50 E10000                   ;Set max print and retract acceleration in mm/s^2. 
M205 X4 Y4 Z0.05 E5                           ;Sets the max speed at which direction changes occur. 0 for infinite jerk. 
M500                                          ;save 

G1 X290            ;move to the X=250 position on the bed 
G1 X0              ;move to the X=0 position on the bed at max speed            
G1 Y290             
G1 Y0 

; *** 2 ***
M204 P10000 T10000 R3000                            ;Set starting print, travel and retract accelaration
M201 X125 Y125 Z50 E10000                   ;Set max print and retract acceleration in mm/s^2. 
M205 X4 Y4 Z0.05 E5                           ;Sets the max speed at which direction changes occur. 0 for infinite jerk. 
M500                                          ;save 

G1 X290            ;move to the X=250 position on the bed 
G1 X0              ;move to the X=0 position on the bed at max speed             
G1 Y290             
G1 Y0   


; *** 3 ***
M204 P10000 T10000 R3000                            ;Set starting print, travel and retract accelaration
M201 X250 Y250 Z50 E10000                   ;Set max print and retract acceleration in mm/s^2. 
M205 X4 Y4 Z0.05 E5                           ;Sets the max speed at which direction changes occur. 0 for infinite jerk. 
M500                                          ;save 

G1 X290            ;move to the X=250 position on the bed 
G1 X0              ;move to the X=0 position on the bed at max speed            
G1 Y290             
G1 Y0  

; *** 4 ***
M204 P708 T708 R3000                            ;Set starting print, travel and retract accelaration
M201 X500 Y500 Z50 E10000                   ;Set max print and retract acceleration in mm/s^2. 
M205 X4 Y4 Z0.05 E5                           ;Sets the max speed at which direction changes occur. 0 for infinite jerk. 
M500                                          ;save 

G1 X290            ;move to the X=250 position on the bed 
G1 X0              ;move to the X=0 position on the bed at max speed            
G1 Y290             
G1 Y0  

; *** 5 ***
M204 P10000 T10000 R3000                            ;Set starting print, travel and retract accelaration
M201 X1000 Y1000 Z50 E10000                   ;Set max print and retract acceleration in mm/s^2. 
M205 X4 Y4 Z0.05 E5                           ;Sets the max speed at which direction changes occur. 0 for infinite jerk. 
M500                                          ;save 

G1 X290            ;move to the X=250 position on the bed 
G1 X0              ;move to the X=0 position on the bed at max speed            
G1 Y290             
G1 Y0  