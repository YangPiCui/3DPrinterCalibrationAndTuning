;M928 Marlin.txt           ; Start SD logging with Marlin firmware
;M929 P"PID.txt" S1        ; Start SD logging with RepRap 1.20+

;M303 E0 S200 C8           ; tune PID for the hotend
;M301 P19.56 I0.71 D134.26 ; Set hotend PID 

;M303 E-1 S70 C8           ; tune PID for the bed
;M304 P1 I2 D3             ; Set bed PID

;M929 S0                   ; End SD logging with RepRap 1.20+
;M29                       ; End SD logging with Marlin firmware

;M500                      ; Save settings