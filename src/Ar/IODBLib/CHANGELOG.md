# Change log

- 0.0.8 - Migrate from AsString to AsBrStr.

- 0.00.7 - Fixed compiler warning in get channel number.

- 0.00.6 - Added new function to get channel numbers.
	   - Will return the number on the end of the PV if there is one
	   ie:Stepper motor AbsPos01 will return 1
	   	  Stepper motor AbsPos02 will return 2
	   
- 0.00.5 - Added new function block that gets information 
		about the task it is called in.

- 0.00.4 - Split up initialization into init, and create.
       - Fixed some issues with datapoints not being found

- 0.00.3 - Changed name from IODatabase to IODBLib

- 0.00.2 - Changed GetINAInfo to have an IN_OUT var for the INADeviceName
		Cleaned things up. Added null pointer detection to GetINAInfo fn.

- 0.00.1 - First version.