# ebsynthUtilities
A simple powershell script to help using ebsytnh. aimed at people who have no clue/don't want to look around too much

This script will cut a video in its frames and perform background detection to generate mask for it, and neatly arrange it in little folders.

You will need :
*Ebsynth installation. Download the portable package from https://ebsynth.com/

Unzip their content in the respective (empty) folders. The result should be like :

ebsynth-EbSynth.exe
       -vcomp140.dll
       
The mask generation uses the code from : https://www.codepasta.com/computer-vision/2019/04/26/background-segmentation-removal-with-opencv-take-2.html
