                   .:                     :,                                          
,:::::::: ::`      :::                   :::                                          
,:::::::: ::`      :::                   :::                                          
.,,:::,,, ::`.:,   ... .. .:,     .:. ..`... ..`   ..   .:,    .. ::  .::,     .:,`   
   ,::    :::::::  ::, :::::::  `:::::::.,:: :::  ::: .::::::  ::::: ::::::  .::::::  
   ,::    :::::::: ::, :::::::: ::::::::.,:: :::  ::: :::,:::, ::::: ::::::, :::::::: 
   ,::    :::  ::: ::, :::  :::`::.  :::.,::  ::,`::`:::   ::: :::  `::,`   :::   ::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  :::::: ::::::::: ::`   :::::: ::::::::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  .::::: ::::::::: ::`    ::::::::::::::: 
   ,::    ::.  ::: ::, ::`  ::: ::: `:::.,::   ::::  :::`  ,,, ::`  .::  :::.::.  ,,, 
   ,::    ::.  ::: ::, ::`  ::: ::::::::.,::   ::::   :::::::` ::`   ::::::: :::::::. 
   ,::    ::.  ::: ::, ::`  :::  :::::::`,::    ::.    :::::`  ::`   ::::::   :::::.  
                                ::,  ,::                               ``             
                                ::::::::                                              
                                 ::::::                                               
                                  `,,`


http://www.thingiverse.com/thing:3397997
The Best Flowrate Calibration Method! by petrzmax is licensed under the Creative Commons - Attribution - Non-Commercial - Share Alike license.
http://creativecommons.org/licenses/by-nc-sa/3.0/

# Summary

<h4>If You enjoyed this guide and You want to say "Thank You" please consider supporting me by sending a tip on thingiverse or my PayPal <p><a href="https://paypal.me/ArturPetrzak">here</a>.</p> </h4>
<br/>

I have tested a lot of different flowrate calibration methods on the internet but methods I found were not accurate, time-consuming or just were not working for me. This is the method I have elaborated by merging a few other methods and adding some my expirence. 

Check my I3 Mega **ULTIMATE upgrade guide!** There is a lot of knowledge which may help You get the best 3D printing results and make Your 3D printer silent. You will find it here:
- http://bit.ly/2OVbu5Z

**Attention!**
Before calibrating flowrate make sure that Your E-Steps are well calibrated. Otherwise, you will waste your time. Also make sure that filament which You are using is good quality - Ø tolerance is not bigger ±0,05 mm. Do not use no-name filaments because their diameter may be fluctuating and it will be impossible to achieve stable results.

**How to calibrate flow rate using this method:**
1. Print the calibration model matching Your nozzle size with flowrate set to 100%. Extrusion width must be set to nozzle diameter.
2. Using calipers, measure width of a few top layers. Do it in the middle of each wall. I recommend measuring from 2 to 5 last layers. But be consequent! Make all measurements in the same way.
3. Take the average value from measuring all walls.
4. Now using the following formula calculate new flowrate value:
A = Expected dimension. If You are using 0.4 nozzle, expected dimension should be twice as large - 0.8 mm.
B = Measured dimension. Value from point 3.
F = Current Flowrate.
(A / B) * F = Your new flowrate value

5. Print the model again but now sliced with new flowrate value.
6. Measure the model again. If average value from measuring all walls is equal to expected dimension You are done. If it's not then calculate flowrate again using current value and repeat the process untill achieving expected resaults.

I wrote this guide for 0.4 mm nozzle. If You have different nozzle diameter use model prepared for Your nozzle size and don't forget to use other values in formula.

Personally for 0.4 mm nozzle I'm setting expected value for 0.82 mm. This guarantees me that real extrusion width will be around 0.41 mm which ensures correct line adhesion.

I'm printing this model at 0.2 mm layer height and I'm achieving good results. If You want to do it more accurate, You can try printing this model at 0.1 mm layer height. It will be more sensitive to flowrate changes so it may be more difficult to set right but You will be able to achieve better results.

In my opinion this is The Best flowrate calibration method I have tried because It's easy fast and accurate. Share Your thoughts and experience in the comments!

# Print Settings

Printer: Anycubic I3 Mega Custom
Rafts: No
Supports: No
Resolution: 0.2 mm
Infill: 0%
Filament_brand: BestFilament
Filament_color: Red
Filament_material: PLA