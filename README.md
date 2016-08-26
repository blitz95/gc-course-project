# gc-course-project
Contains files for Human Activities Recognition Data Project for Getting and Cleaning Data class project  

---

author: "blitz95"  
date: "August 25, 2016"  

---

####Coursera: Getting and Cleaning Data  
####Course Project

Project Objective: Demonstrate the ability to collect, work with and clean a data set.    
The raw data was taken from a data set produced from a study of Human Activity Recognition Using Smartphones.  
Information from the study is summarized below.  

The following are the required deliverables:

1. HAR_tidy_data.txt - A tidy data set showing the means calculated for values of variables that include the substrings, "mean" and "std" in their variable names from a set of 561 variables.  The means of the selected variables are calculated for each Activity/Subject ID combination.   
2. README.Rmd - A file providing a background and overview of the project
3. R scripts to process the data  
	+ HARReqPackages.R - Loads required packages if necessary  
	+ run_analysis.R - Transforms the "raw" data set to the required tidy data set   HAR_tidy_data.txt in item 1     
4. Code.pdf - Code book describing the tidy data set, as well as information on the "raw" data set  

####Required Packages
Functions from the following packages were utilized in the run_analysis.R script.   
Please ensure that you have installed the following packages prior to running the run_analysis.R script.  
If you do not have them installed, you can run the HARReqPackages.R to install them.     

* R.utils
* data.table
* dplyr

#####Note:  
run_analysis.R and HARReqPackages.R can be called by using the source() function with the file path name in the console window or opening the files in RStudio and selecting source.  

The run_analysis script assumes that the data you will use will be located in your working directory
It takes a few minutes, but will output the first 5 lines of the file to the screen as well as writing the file to the current directory.  

You can use read.table("HAR_tidy_data.txt") to read the file.

A zip file of the raw data files can be found at the following link.

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>


####Data Source and Raw Data File Overview    
The source of the data is from the following experiment:  

Human Activity Recognition Using Smartphones Dataset
Version 1.0
 
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  
Smartlab - Non Linear Complex Systems Laboratory  
DITEN - Università degli Studi di Genova.  
Via Opera Pia 11A, I-16145, Genoa, Italy.  
activityrecognition@smartlab.ws  
www.smartlab.ws  

--- 
  
####Experiment Description and Measurements:  
The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years.  

Each person performed six activities:    
WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING  
while wearing a smartphone (Samsung Galaxy S II) on their waist.    

3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were measured using the embedded accelerometer and gyroscope.  
 
The experiments were video-recorded to label the data manually.  
The obtained dataset was randomly partitioned into two sets   

* 70% (21 subjects) of the volunteers were selected for the training data set    
    + Training Subject ID numbers: 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30    
* 30% (9 subjects) of the volunteers were selected for the test data set    
    + Test Subject ID numbers: 2, 4, 9, 10, 12, 13, 18, 20, 24    

The sensor signals (accelerometer and gyroscope) were pre-processed by 
applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity.  

The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used.   

From each window, a vector of features was obtained by calculating variables from the time and frequency domain.  

See 'features_info.txt' for more details. 

The resulting records containing 561-feature vector for each sample are recorded in a measurement file X_train for the traning data and X_test for the test data.     

---

####Datasets used for class project    
The following data files were used for this class project:  

Data files applicable to both training and test data sets:  

 * README.txt:              The README.txt was edited to reflect the current project
 * features.txt:            List of all features in the 561-feature vector
 * features_info.txt: 	    Shows information about the variables used on the feature vector.
 * activity_labels.txt:     Links the class labels with their activity name.  
 
Test measurement data files:  

 * test/subject_test.txt:   Each row identifies the subject who performed the activity for each test record.  
 * test/X_test.txt: 	    Contains 561 time and frequency domain variable measurements for the 2,947 test data records
 * test/y_test.txt: 	    Label IDs indicating activity for each test record.   

Traning measurement data files:  

 * train/subject_train.txt: Each row identifies the subject who performed the activity for each training record.  
 * train/X_train.txt: 	    Contains 561 time and frequency domain variable measurements for the 7,352 training data records
 * train/y_train.txt:    	Label IDs indicating activity for each training record.  


####Notes on data:  

* Features were normalized and bounded within [-1,1].  
* Each feature vector is a row on the text file.  

Information on the variables in each input file are as follows:
Additional information on variables from the raw data set
is contained in the Code Book following the description of variables
in the resulting tidy data set, HAR_tidy_data.txt  

activity_labels.txt  

1. WALKING  
2. WALKING_UPSTAIRS  
3. WALKING_DOWNSTAIRS  
4. SITTING  
5. STANDING  
6. LAYING  

subject_test.txt    
A listing of each subject number for each record contained in the 
test measurement set.    
* Unique Test Subject IDs:2, 4, 9, 10, 12, 13, 18, 20, 24

subject_train.txt  
A listing of each subject number for each record contained in the 
training measurement set.    
* Unique Training Subject IDs: 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30

Information on the meaurements are contained in the CodeBook.pdf  

---

####Overall Processing Steps Contained in run_analysis.R  

####The HARReqPackagesInst.R script can be run to install the required packages.

(data verification/summarization steps have been removed from the script)   

* Downloaded, unzipped the zipped file and saved raw data files to current working directory
* Activity Labels  
    + Read the activity_labels.txt file using read.table  
    + Ran struct and head function to view data    
    + Split the strings in the Activity Labels data table    
    + Converted the split string vector to a data frame    
    + Created names for the columns in the actLabels data frame    
* Features   
    + Read the features.txt file using read.table  
    + Ran head, tail, str functions to view data  
    + Used grep function to find all feature names that contained either "Mean" "mean" or "std" and return index numbers for use to extract columns from the test and train data. Included the meanFreq columns.  
    + Ran str function on the index vector to determine that there are 79 elements to use later to verify correct size of subsetted data.  

Test and Training Data Set Creation - for both test and training data sets  

* Subject Data  
    + Created subject_test/train object using read.table on subject_test/train.txt files with carraige return separator     
* Activity Label Data    
    + Created test/trainy object using read.table on y_test/train.txt files with carraige return separator      
* Test/Train Data      
    + Read in 10 rows of the X_test/train.txt file    
    + Ran the class function on the 10 row object to determine the class of all 561 columns    
    + Read in complete X_test/train.txt file using read.table with colClasses = classes argument   
    + Ran str, head, tail functions to verify 561 columns (class numeric) and 2,794 records/observations     
    + Ran a check for NAs to verify that there were no NAs in the data set    
    + Extracted the columns corresponding to the indices from the activities label file
    that contained "mean" and "std" by subsetting the complete test data set    
* Test/Train Data Set    
    + Created an object, test_data, by binding, subject_test, testy, and testxMnStd objects using cbind    

Combined Test and Training Data sets into on data set using rbind   

Created a character vector, fVarNames, of variable names that contain the strings "mean" and "std"     
* Ran the function str on fVarNames to determine that there are 79 elements in the vector   
    
Provide names for the combined data set    

Merged the combined data set data frame and actLabels data frame    

Use aggregate function to take the average of the values for each variable grouped by ActivityName and SubjectID  

Saved the data set to HAR_tidy_data object.

Wrote the data set HAR_tidy_data.txt using write.table with default values   

---

For more information about the raw dataset contact: activityrecognition@smartlab.ws  

#######[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.