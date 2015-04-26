# harus-project
Coursera getdata-013 course project on data for **H**uman **A**ctivity **R**ecognition **U**sing **S**martphones. The project involves merging and transforming an original dataset for machine learning for recodnition by mobile devices of standard human activities by measuring signals from the device's built-in accelerometer and gyroscopes.

## Original dataset
The original dataset can be found on the [UCI Machine Learning Repository site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The documentation of the original dataset, along with in-depth explanation of the experimental settings, can be found in the [data directory](https://github.com/ivogeorg/harus-project/tree/master/data/UCI%20HAR%20Dataset). A good place to start is the supplied [README.txt](https://github.com/ivogeorg/harus-project/blob/master/data/UCI%20HAR%20Dataset/README.txt).

## Transformations
The transformations comprising the project are performed by the [run_analysis.R script](https://github.com/ivogeorg/harus-project/blob/master/run_analysis.R). The script has inline comments marking out all each major step. In summary, the original dataset, which is split in a 70:30 ratio into training and test sets, is: 

1. merged, both horizontally, across the train-test dimension, and vertically, along the subject-features-label dimension;  

2. filtered, to retain only the columns for the mean and standard deviation values for 33 of the original feature variables, which are described in the file [features_info.txt](https://github.com/ivogeorg/harus-project/blob/master/data/UCI%20HAR%20Dataset/features_info.txt);  

3. summarized, to show each of the variables averaged over each activity for each subject; and  

4. cleaned up, so that variable names and factors are human readable  

## Resulting dataset
The resulting dataset is saved in plain-text space-delimited file [subj_acty_avg.txt](https://github.com/ivogeorg/harus-project/blob/master/data/subj_acty_avg.txt) in the data directory. It can be imported into R/RStudio with *read.table()* with the option *header=TRUE*.  

The dataset is tidy per the requirements of Week 1 of the course getdata-013. It is in the wide-data format.  

The data dictionary [codebook.md](https://github.com/ivogeorg/harus-project/blob/master/codebook.md) contains descriptions of the variables in the new dataset.  
