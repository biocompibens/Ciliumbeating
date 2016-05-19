# Centriole analysis
This is the toolbox created for studying 'Centriole stability'. The ImageJ plugin is used for the Centrin and Cep164 detection; and the Matlab plugin is used for extracting the cilia beating direction and corresponding analysis

Step 1

The imagej Macro file titled 'Centrin2_detection.ijm' and 'Cep164_detection.ijm' is used to detect the centrins and Cep164 respectively. To run this plugin the FIJI/Imagej needs to have java3d, LOG3D and 3D fast filter installed. Also in each macro we need to mention which channel in the stack represent the centrins/Cep164. In our case it is channel 1/3. This macro can read all the flies in the dataset folder. We need to select the folder that have all the input images and input images only. Then we can select the result folder that should save all the processed images.

Step 2

The cell profiler pipeline 'Cell_detect1.proj' can load the files in the previous steps and use semi manual approaches to detect the patches. It will make the initial estimation of the patches based on centriole density and then use provide an user interface to manually correct or add patches.

Step 3

'Vectorplot6ND.m' in the code folder is the main matlab script that reads all the processed file, performs the analysis and generate corresponding plots.



