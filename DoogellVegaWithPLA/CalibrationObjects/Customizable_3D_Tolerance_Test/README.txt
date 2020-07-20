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


https://www.thingiverse.com/thing:2318105
Customizable 3D Tolerance Test by zapta is licensed under the Creative Commons - Public Domain Dedication license.
http://creativecommons.org/publicdomain/zero/1.0/

# Summary

NOTE TO SIMPLIFY 3D USERS:  several users reported that S3D doesn't slice this model correctly and I was able to reproduce it, the 0.2 part is fused at about Z=10mm http://i.imgur.com/99Qa9SV.png. If this happens to you, try one of these workaround (all worked for me)  1)  rotate the part on the Z axis by 90 degrees, or 2) Click the menu entry Mesh | Separate Connected Surfaces before slicing.

This thing allows you to test the accuracy of your printing process and to determine the optimal clearance between moving parts (e.g. hinges).  It was inspired by this Maker's Muse video https://youtu.be/TYuLVN3YHw8 and was designed with OpenScad (source file included here).

The test allow you to test up to 7 different clearances of your choice. Each clearance is tested using a cylinder and a rod that have the specified clearance between them. After printing, examine which of the clearances resulted in free moving parts, which can be freed by breaking them in using the screwdriver slot at the bottom and which are simply stuck. 

Notes:
* The model doesn't test tolerance of first layer which is typically more problematic due to 'squashing' it against the bed and always has ample clearance on the first layer.
* The model has inside each cylinder an overhang of 45%. This is used to keep the rotating centers from falling out.
* The clearances are measured horizontally, on the x,y plane, parallel to the printed layers. As a result, the actual clearance at the overhang sections is lower but I believe that the horizontal clearance of each layer is what matters.
* With my 3D printing process (FFCP, PLA, S3D), I can release 0.2mm clearance but not 0.15mm clearance.

To customize this test click on the Customizer button in this page and change the model parameters.