

### Introduction

The file `run_analysis.Rmd` performs the cleaning, transformation and merger of the raw dataset files dowloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

put into  the 5 steps described in the course project's definition.

#### Step 0: Download of Dataset into the defined working directory

The file `Dataset.zip` is downloaded into the defined folder. The working directories will be based in the folder structure already set in and extracted from the zipped file.

#### Step 1: Extraction of train and test sets for Data, Labels and Subjects

##### Step 1.1: Extraction of datasets
  - Dataset "Features": List of measurable features. Source is downloaded file `features.txt`.
  - Dataset "X": Quantitative information. Split in `x_train.txt` (train set) and `x_test.txt` (test set).
  - Dataset "Y": Activity information. Split in `y_train.txt` (train set) and `y_test.txt` (test set).
  - Dataset "Subject": Information related to the subjects who performed the sport activity. Split in `subject_train.txt` (train set) and `subject_test.txt` (test set).

  - Variables:
      - `xTrain` and `xTest` contain the collected quantitative data as downloaded. Source: Dataset "X" `.txt` files mentioned above.
      - `yTrain` and `yTest` contain the activity information as downloaded. Source: Dataset "Y" `.txt` files mentioned above.
      - `SubTrain`and `SubTest` contain the data of the subjects who performed the sport activities that generated the collected quantitative data as downloaded. Source: Dataset "Subject" `.txt` files mentioned above.
  
##### Step 1.2: Merger of train and test data sets
We are asked to put all the information together in a sole dataset and make it understandable. In this step, we merge train and test sets of Data, Activity and Subject into only one set for each. This is, train and test datasets shown above are merged by rows using the `rbind()` function. 

  - Variables:
      - `xMerged`: output of merging rows of train and test sets of quantitative information collected.
      - `yMerged`: output of merging rows of train and test sets of activity information.
      - `SubjectMerged`: output of merging rows of train and test sets of subjects' information.

#### Step 2: Extraction of columns showing measurements of mean and standard deviation

The aim of this step is to keep only those columns that show mean and standard deviation measures. Additionally, the dataset generated with mean and standard deviation measures are in this step correctly labelled using the information provided in the file `features.txt`.

  - Variables:
    - `x_MeanStdev`: dataset `xMerged` with named columns


#### Step 3: Use of descriptive activity names

In order to to identify the activities in each row of the dataset, we Use the descriptive names of each activity as stored in the provided file `activity_labels.txt`. In the original dataset, the activities are indicated with the values 1 to 6. The file `activity_labels.txt` contains their corresponding description.

  - Variables:
    - `Activity`: correspondence table between numeric codes and activity definitions
    - `ActivityLabel`: dataset `yMerged` with named columns
    

#### Step 4: Appropriate labeling of data sets and set of main Clean & Tidy Dataset

Columns and activities are not properly labelled. In Steps `4.1` and `4.2`, all this is correctly named and labelled according to the information provided in additional files.

In step `4.3`, we merge the already correctly named datasets into a full clean and tidy dataset. This clean dataset is transcribed into the file called `01_TidyDataSet.txt`. The file has been uploaded to the repository of this exercise.

  - Variables:
    - `Subject`: dataset `SubjectMerged` with named columns


#### Step 5: Creation of dataset of averages of each activity and subject for each variable 

Finally, we generate a new dataset with all the average measures for each subject and activity type:
  - 30 subjects
  - 6 activities

  ...this means 30 x 6 = 180 rows.

The output file is called `02_AveragesDataSet.txt`, and has been uploaded to the repository of this exercise.

  - Variables:
    - `FullData`: merge of datasets `x_MeanStdev`, `ActivityLabel` and `Subject`

