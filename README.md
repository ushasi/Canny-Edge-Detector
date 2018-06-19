# Canny-Edge-Detector
Implementation of Canny edge detector

In this project there are three functions Canny edge, Gaussian Mask and Convolution. These functions are called in Canny_gui.m.
Once we execute Canny.gui.m file. Immideately GUI will open which has 
1. Browse button:- Select a image which you want to process.
2. Scroll Bar1:- First scroll bar is for selecting a sigma value. You can select sigma value from 0 to 50.
3. Pop_up Menu:- Pop_up menu is for selectig the size of the Gaussian mask. Here you can select 3,5 or 7 for 3x3,5x5 and 7x7 mask respectively.
4.Scroll Bar2:- Second scroll bar is for selecting lower threshold value. You can select the lower threshold from 0 to 1.
5.Scroll Bar3:- Third scroll bar is for selecting Upper threshold value. You can select the upper threshold from 0 to 1.
6.Push Button:-By clicking on the last push Button i.e. OK the program will execute with given parameters.

NOTE:
1.Before execution you need to set a path of the folder where all this matlab files are stored by selecting set path tab.
2.Once GUI is open it is essential to select the all values by clicking on respective buttons. e.g. If you want to select the mask size of 3 then you have to click on pop-up menu and select the 3 value. Otherwise variable will not return any value.


Description of the parameter.
1. Sigma:- Sigma will decide the smoothing. If sigma value is more then more smoothing.
2. Mask Size:- Mask Size will also plays imortant role in smoothing. Smoothing will increses as incresed in mask size.
3. Dual Threshold:- There are two threshold in Canny edge detector. The gradient magnitude above than upper theshold will be treated as Edge pixel the gradient value lower than lower threshold will be treated as No edge pixel. And the values in between the two threshold will be consider based on neghibouring condition. 

Some combinations of Parameter values for executing the code
Case1 Different Mask
Sigma=0.357142, Mask 3, Lower Threshold=0.051948 Upper Threshold=0.097403
Sigma=0.357142, Mask 5, Lower Threshold=0.051948 Upper Threshold=0.097403
Sigma=0.357142, Mask 7, Lower Threshold=0.051948 Upper Threshold=0.097403 

Case2 Different Sigma
Sigma=0.357142, Mask 3, Lower Threshold=0.051948 Upper Threshold=0.097403
Sigma=0.90909, Mask 3, Lower Threshold=0.051948 Upper Threshold=0.097403
Sigma=4.058, Mask 3, Lower Threshold=0.051948 Upper Threshold=0.097403

Case3 Different Threshold
Sigma=1.0065, Mask 3, Lower Threshold=0.1883 Upper Threshold=0.2337
Sigma=1.0065, Mask 3, Lower Threshold=0.2077 Upper Threshold=0.3181
Sigma=1.0065, Mask 3, Lower Threshold=0.2532 Upper Threshold=0.3506
