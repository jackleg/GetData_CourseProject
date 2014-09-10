GetData_CourseProject
=====================
## how script works

### Step 1.
1. first, read metadata - feature and activity labels from features.txt and activity_labels.txt
2. read X_train.txt and X_test.txt files, and give them name by feature names.
3. read Y_train.txt, Y_test.txt, subject_train.txt and subject_test.txt. And attach them to X_train and X_test respectively.
4. merge X_train and X_test into allData.

### Step 2.
1. select feature names by using grep.
2. select mean, std, y, and subject data from allData.

### Step 3.
1. merge Step 2 Data(meanStdData) and activityLabels

### Step 4.
1. make descriptive names and set.

### Step 5.
1. calculate average of each variables for each (ActivityCode, SubjectId) group by using ddply.

## Code Book
*ActivityCode*: activity code.
1: WALKING
2: WALKING_UPSTAIRS
3: WALKING_DOWNSTAIRS
4: SITTING
5: STANDING
6: LAYING

*SubjectId*: subject id. from 1 to 30.

*other variables*: Other variables are from course project data sets.
