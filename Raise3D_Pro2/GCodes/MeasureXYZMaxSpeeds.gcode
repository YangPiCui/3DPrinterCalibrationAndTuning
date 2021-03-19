G21        ;metric values
G90        ;absolute positioning
M82        ;absolute extrusion mode
M107       ;start with the fan off
G28		   ;performe homing routine

G0 Z50            ;move the platform down 50mm

G1 F999999         ;set feedrate to the max mm/s.

;G4 S5              ;wait 5 seconds for manually starting stop watch
;G1 X250            ;move to the X=250 position on the bed 
;G4 S10             ;wait 10 seconds for manually reseting stop watch
;G1 X0              ;move to the X=0 position on the bed at max speed 

;G4 S10             
;G1 Y300            
;G4 S10            
;G1 Y0   

;G1 Z0        
;G4 S10            
;G1 Z300            
;G4 S10            
;G1 Z0  
