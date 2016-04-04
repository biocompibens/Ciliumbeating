// Variables
run("Close All");
// Sigmas for LoG
logX = 2;
logY = 2;
logZ = 2;


// Radius for maxima detection
rX = 2;
rY = 2;
rZ = 2;
i = 1; 

 dir = getDirectory("Choose a Directory "); 
 dir2 = getDirectory("Choose a Result Directory "); 
 print(dir);
 list = getFileList(dir); 
 ch=1;
 //print(list[1]);
 //setBatchMode(true); 
     for (k=0; k<list.length; k++) { 
        path = dir+list[k]; 
        
        print(path);
        run("Bio-Formats Importer", "open=["+path+"]");
        //open(path); 
       // run("8-bit"); 
      //  run("Make Binary"); 
       // run("Convert to Mask"); 
       // makeRectangle(482, 230, 1174, 1252); 
      //  run("Analyze Particles...", 
      //     "size=150-Infinity circularity=0.00-1.00 show=Nothing clear display"); 
        path2 = dir2+File.nameWithoutExtension+ch; 
       

//run("Open...");

run("Grays");


// Get window and position
source = getTitle();


selectWindow(source);
getLocationAndSize(sourceX, sourceY, sourceW, sourceH); 
getDimensions(width, height, channels, slices, frames);

middle = round(slices/2);

run("Duplicate...","title=Frame"+i+" duplicate channels="+ch);
selectWindow("Frame"+i);
run("Gaussian Blur 3D...", "x=.5 y=.5 z=.5" );
while (getTitle() != "Frame"+i) {
		wait(500);
	}

	
selectWindow("Frame"+i);
print("Running LoG...");
run("LoG 3D", "sigmax="+logX+" sigmay="+logY+" sigmaz="+logZ+" displaykernel=0 volume=1");

while (getTitle() != "LoG of Frame"+i) {
		wait(500);
	}

selectWindow("LoG of Frame"+i);
//setOption("BlackBackground", false);
//run("Make Binary", "method=Otsu background=Light");
//run("Invert", "stack");

// first value (-50) is the controlling parameter. Ideal case should be zero. but depending on image intensity they can be varied. 
// less the value less points will be detected
setThreshold(-50, 65535); 
run("Threshold", "thresholded remaining"); 
run("16-bit");
run("Multiply...", "value=257.000 stack");
//run("Enhance Contrast", "saturated=0.35");
//run("Close");
//run("16-bit");

wait(500);	
	
	// Subtraction
	print("Subtracting LoG from Frame"+i+"...");
	imageCalculator("Subtract create stack", "Frame"+1,"LoG of Frame"+1);
	wait(500);


	// 3D Local maxima
	print("Running 3D Local Maxima detection...");
	run("3D Fast Filters","filter=MaximumLocal radius_x_pix="+rX+" radius_y_pix="+rY+" radius_z_pix="+rZ+" Nb_cpus=8");
	wait(500);

print("*** All done !");

selectWindow("Frame"+i);
run("Enhance Contrast", "saturated=0.35");
selectWindow("Frame"+i);
run("Z Project...", "projection=[Max Intensity]");


selectWindow("3D_MaximumLocal");
run("Z Project...", "projection=[Max Intensity]");

run("Enhance Contrast...", "saturated=0 normalize");

// This is value of removing weak detection. 1638 is 2.5% of 65535) 
setThreshold(1638, 65535); 
run("Threshold", "thresholded remaining"); 

run("16-bit");
run("Multiply...", "value=257.000 stack");
run("Invert LUT");

run("Find Maxima...", "noise=10 output=[Single Points]");

run("16-bit");
run("Multiply...", "value=257.000 stack");
run("Invert LUT");

run("Merge Channels...", "c2=[MAX_3D_MaximumLocal Maxima] c4=MAX_Frame1 keep ignore");
saveAs("tiff", path2+"-Overlay.tif"); 
selectWindow("MAX_3D_MaximumLocal Maxima");
saveAs("tiff", path2+"-MAX_3D.tif"); 

selectWindow("MAX_Frame1");
saveAs("tiff", path2+"-MAX_F.tif");
 //run("tiff", path2+"-bin.tif"); 
 run("Close All");
       // close(); 
      //  saveAs("results", path2+"-results.txt"); 
 } 

//run("Tiff...");
//run("Gel (105K)"); 
//setThreshold(0, 114); 
//run("Make Binary", "thresholded remaining"); 
