https://www.thingiverse.com/thing:2362201

First eyeball the offsets so the extruders fall in around 1mm range when switching between them (use T0 and T1 command).

Load both objects into your slicer without any offset. Assign each to a different extruder and print. They should be able to bind together without any overlap if your extruder offset is close enough.

After printing the object, find the short line that align best with the line on its opposite side, count how many short lines are on its left and right. If it's 10 vs 10, that means a perfect alignment. If not, change the offset value by 0.1 * (numOfShortLineOnLeft - 10), then print again to verify.

After finishing X axis, rotate the objects by 90 degrees to calibrate Y axis.