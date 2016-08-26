#Desiree Johnson
#Coursera - Getting and Cleaning Data Class Project
#This script downloads a zipped file containting data from Human Activity
#Recognition study. Ref:
#[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
#Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly
#Support Vector Machine. International Workshop of Ambient Assisted Living
#(IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

#Data is downloaded and unzipped
#It is then tranformed into a dataset which is a subset of the means of
#"mean" and "std" variables summarized by ActivityName and SubjectID.
#Please see the README.txt and Code Book files for more information

#This script installs required packages if they are not
#already installed

#Install R.utils package to enable downloadig of zipped file
install.packages("R.utils")

#Install data.table package
install.packages("data.table")

#Install dplyr package
install.packages("dplyr")
