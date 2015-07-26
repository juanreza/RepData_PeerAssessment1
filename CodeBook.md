# CodeBook for Assignment 2: Activity Sensor Measurements

This CodeBook describes the variables, the data, and the transformations or work performed
   to clean up the data.
The associated README.md explains how the scripts work and how they are connected.

The measurement data was actually quite "clean" by real world norms.
Mostly it only needed reformatting. Messy items were eliminated along with deleting all columns not related to mean and std.
See section 2, Exhibit 1.
The manually-recorded labels of activity categories was also applied by simply substituting activity name for activity code number. See section 3, Exhibit 2.

See the section on Study Design at the bottom of this document.


init() ## call generateActivityCodeMap()

##1. Merges the training and the test sets to create one data set.

The training and test sets were read into separate matrixes. The numerical data was found in the format with an e exponent and these were preserved during the read, rather than rounding the value. 

The corresponding subject codes for training and test were injected into these matricies. Each row in the subject file supplied a subject code for the corresponding row in the matrix, training or test respectively.

Then the two matrixes were simply combined by effectively appending the test matrix to the training matrix, taking advantage of their columns correspondance.

##2. Extracts only the measurements on the mean and standard deviation for each measurement. 

The original features were modified for use as concise column names and for the purpose of subsetting by "mean" and "std".
There were duplicate names but they were unrelated to mean and std and, so, were filtered out.

###Exhibit 1
The only real "cleaning" was to change the cluttered feature names into concise symbology.

Below is a legend of the map of the changes which follows the Legend. In principle, each embedded word or abbreviation was changed to a single letter symbol. Delimiter characters were removed, except where certain parentheses seemed to usefully delineate words, and were changed to dash. Also, all of the "mean" and "std" words were moved to the end (right) of the symbolic name because of the central objective of thsi assignment based on those categories.

#### LEGEND
B Body
a Acceleration
G Gravity
J Jerk
g gyro
M Magnitude
F Frequency
Λ angle 
μ mean
σ std --- R shows this as s
t and f are unchanged from the original feature symbology for time and frequency domains, respectively.

The result of this mapping is a nice set of column widths and easy to distinguish headings. The renaming filter outputs the map below as a side-effect for the purpose of putting it into this CodeBook.


#### Map from new symbolic column name to the original feature name                                
 [1,] "tBa-X-µ"     "tBodyAcc-mean()-X"                   
 [2,] "tBa-Y-µ"     "tBodyAcc-mean()-Y"                   
 [3,] "tBa-Z-µ"     "tBodyAcc-mean()-Z"                   
 [4,] "tBa-X-s"     "tBodyAcc-std()-X"                    
 [5,] "tBa-Y-s"     "tBodyAcc-std()-Y"                    
 [6,] "tBa-Z-s"     "tBodyAcc-std()-Z"                    
 [7,] "tGa-X-µ"     "tGravityAcc-mean()-X"                
 [8,] "tGa-Y-µ"     "tGravityAcc-mean()-Y"                
 [9,] "tGa-Z-µ"     "tGravityAcc-mean()-Z"                
[10,] "tGa-X-s"     "tGravityAcc-std()-X"                 
[11,] "tGa-Y-s"     "tGravityAcc-std()-Y"                 
[12,] "tGa-Z-s"     "tGravityAcc-std()-Z"                 
[13,] "tBaJ-X-µ"    "tBodyAccJerk-mean()-X"               
[14,] "tBaJ-Y-µ"    "tBodyAccJerk-mean()-Y"               
[15,] "tBaJ-Z-µ"    "tBodyAccJerk-mean()-Z"               
[16,] "tBaJ-X-s"    "tBodyAccJerk-std()-X"                
[17,] "tBaJ-Y-s"    "tBodyAccJerk-std()-Y"                
[18,] "tBaJ-Z-s"    "tBodyAccJerk-std()-Z"                
[19,] "tBg-X-µ"     "tBodyGyro-mean()-X"                  
[20,] "tBg-Y-µ"     "tBodyGyro-mean()-Y"                  
[21,] "tBg-Z-µ"     "tBodyGyro-mean()-Z"                  
[22,] "tBg-X-s"     "tBodyGyro-std()-X"                   
[23,] "tBg-Y-s"     "tBodyGyro-std()-Y"                   
[24,] "tBg-Z-s"     "tBodyGyro-std()-Z"                   
[25,] "tBgJ-X-µ"    "tBodyGyroJerk-mean()-X"              
[26,] "tBgJ-Y-µ"    "tBodyGyroJerk-mean()-Y"              
[27,] "tBgJ-Z-µ"    "tBodyGyroJerk-mean()-Z"              
[28,] "tBgJ-X-s"    "tBodyGyroJerk-std()-X"               
[29,] "tBgJ-Y-s"    "tBodyGyroJerk-std()-Y"               
[30,] "tBgJ-Z-s"    "tBodyGyroJerk-std()-Z"               
[31,] "tBaM-µ"      "tBodyAccMag-mean()"                  
[32,] "tBaM-s"      "tBodyAccMag-std()"                   
[33,] "tGaM-µ"      "tGravityAccMag-mean()"               
[34,] "tGaM-s"      "tGravityAccMag-std()"                
[35,] "tBaJM-µ"     "tBodyAccJerkMag-mean()"              
[36,] "tBaJM-s"     "tBodyAccJerkMag-std()"               
[37,] "tBgM-µ"      "tBodyGyroMag-mean()"                 
[38,] "tBgM-s"      "tBodyGyroMag-std()"                  
[39,] "tBgJM-µ"     "tBodyGyroJerkMag-mean()"             
[40,] "tBgJM-s"     "tBodyGyroJerkMag-std()"              
[41,] "fBa-X-µ"     "fBodyAcc-mean()-X"                   
[42,] "fBa-Y-µ"     "fBodyAcc-mean()-Y"                   
[43,] "fBa-Z-µ"     "fBodyAcc-mean()-Z"                   
[44,] "fBa-X-s"     "fBodyAcc-std()-X"                    
[45,] "fBa-Y-s"     "fBodyAcc-std()-Y"                    
[46,] "fBa-Z-s"     "fBodyAcc-std()-Z"                    
[47,] "fBa-F-X-µ"   "fBodyAcc-meanFreq()-X"               
[48,] "fBa-F-Y-µ"   "fBodyAcc-meanFreq()-Y"               
[49,] "fBa-F-Z-µ"   "fBodyAcc-meanFreq()-Z"               
[50,] "fBaJ-X-µ"    "fBodyAccJerk-mean()-X"               
[51,] "fBaJ-Y-µ"    "fBodyAccJerk-mean()-Y"               
[52,] "fBaJ-Z-µ"    "fBodyAccJerk-mean()-Z"               
[53,] "fBaJ-X-s"    "fBodyAccJerk-std()-X"                
[54,] "fBaJ-Y-s"    "fBodyAccJerk-std()-Y"                
[55,] "fBaJ-Z-s"    "fBodyAccJerk-std()-Z"                
[56,] "fBaJ-F-X-µ"  "fBodyAccJerk-meanFreq()-X"           
[57,] "fBaJ-F-Y-µ"  "fBodyAccJerk-meanFreq()-Y"           
[58,] "fBaJ-F-Z-µ"  "fBodyAccJerk-meanFreq()-Z"           
[59,] "fBg-X-µ"     "fBodyGyro-mean()-X"                  
[60,] "fBg-Y-µ"     "fBodyGyro-mean()-Y"                  
[61,] "fBg-Z-µ"     "fBodyGyro-mean()-Z"                  
[62,] "fBg-X-s"     "fBodyGyro-std()-X"                   
[63,] "fBg-Y-s"     "fBodyGyro-std()-Y"                   
[64,] "fBg-Z-s"     "fBodyGyro-std()-Z"                   
[65,] "fBg-F-X-µ"   "fBodyGyro-meanFreq()-X"              
[66,] "fBg-F-Y-µ"   "fBodyGyro-meanFreq()-Y"              
[67,] "fBg-F-Z-µ"   "fBodyGyro-meanFreq()-Z"              
[68,] "fBaM-µ"      "fBodyAccMag-mean()"                  
[69,] "fBaM-s"      "fBodyAccMag-std()"                   
[70,] "fBaM-Fµ"     "fBodyAccMag-meanFreq()"              
[71,] "fBBaJM-µ"    "fBodyBodyAccJerkMag-mean()"          
[72,] "fBBaJM-s"    "fBodyBodyAccJerkMag-std()"           
[73,] "fBBaJM-Fµ"   "fBodyBodyAccJerkMag-meanFreq()"      
[74,] "fBBgM-µ"     "fBodyBodyGyroMag-mean()"             
[75,] "fBBgM-s"     "fBodyBodyGyroMag-std()"              
[76,] "fBBgM-Fµ"    "fBodyBodyGyroMag-meanFreq()"         
[77,] "fBBgJM-µ"    "fBodyBodyGyroJerkMag-mean()"         
[78,] "fBBgJM-s"    "fBodyBodyGyroJerkMag-std()"          
[79,] "fBBgJM-Fµ"   "fBodyBodyGyroJerkMag-meanFreq()"     
[80,] "Λ›-tBa-G-µ"  "angle(tBodyAccMean,gravity)"         
[81,] "Λ›-tBaJ-G-µ" "angle(tBodyAccJerkMean),gravityMean)"
[82,] "Λ›-tBg-G-µ"  "angle(tBodyGyroMean,gravityMean)"    
[83,] "Λ›-tBgJ-G-µ" "angle(tBodyGyroJerkMean,gravityMean)"
[84,] "Λ›-G-X-µ"    "angle(X,gravityMean)"                
[85,] "Λ›-G-Y-µ"    "angle(Y,gravityMean)"                
[86,] "Λ›-G-Z-µ"    "angle(Z,gravityMean)"   




#3. Uses descriptive activity names to name the activities in the data set

The map from activity code to descriptive activity names was given in an activity_labels.txt file. It was only necessary to read that map, substitute names for numbers and inject them into the activity column.


#4. Appropriately labels the data set with descriptive variable names. 

This has already been accomplished in step #2. 
The symbolic variable names are considered descriptive from the perspective of science, technology, engineering, and math, which is the doamin of this course and the premise of the data set. ... as constrasted with a wish for complete English words for variable names, which would be appropriate if the problem domain were business, law, or the consumer public for example.

David Hood says, "Tidy means easy for computers to process, not pleasing to the human eye."


#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The average of each of the remaining 86 columns was averaged and a new matrix generated. The contents are written to combinedTrainingAndTestData.txt.

The tidy date can be read with this command (in the Project's root directory):

    data <- read.table(combinedTrainingAndTestData.txt, header = TRUE)

    Also try:
    View( combinedTrainingAndTestData.txt )

----------------------

##Study Design

All information about the design of the study resulting in our tidy data version of the study's data comes from the "features_info.txt" document and is copied verbatim below. 


Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope
   3-axial raw signals tAcc-XYZ and tGyro-XYZ.
 These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz.
 Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
 Similarly, the acceleration signal was then separated into body
  and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 


Subsequently, the body linear acceleration and angular velocity
 were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).
  Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm
 (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing
 fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag.
 (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

Fetal Bovine Serum USA origin, sterile-filtered, suitable for ...



www.sigmaaldrich.com/catalog/product/.../f2442?lang...
