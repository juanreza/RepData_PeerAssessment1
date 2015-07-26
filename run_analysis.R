# to run this

setwd("C:/edu/_DataScienceJohnsHopkins/_GettingCleaningData/Project")

# source("analysis1Main.txt")

source("analysis2init.txt")

source("analysis3readAndProcessFeatures.txt")

source("analysis4readAndProcessMeasurements.txt")


init()


#1. Merges the training and the test sets to create one data set.
# also injects the subject identifier on each respective row.


#1a) prepare paths to the measurement data
trainPath <- file.path( trainDir, "X_train.txt")
testPath <- file.path( testDir, "X_test.txt")


#1b) read the subject identifiers
p <- file.path( trainDir, "subject_train.txt")
trainSubjectsRead <-  read.csv( p,   header=FALSE, sep=" ",  comment.char = "#",  quote = "\"", stringsAsFactors=FALSE)
p <- file.path( testDir, "subject_test.txt")
testSubjectsRead <-  read.csv( p,   header=FALSE, sep=" ",  comment.char = "#",  quote = "\"", stringsAsFactors=FALSE)


p <- file.path( trainDir, "y_train.txt")
trainActivityRead <-  read.csv( p,   header=FALSE, sep=" ",  comment.char = "#",  quote = "\"", stringsAsFactors=FALSE)
p <- file.path( testDir, "y_test.txt")
testActivityRead <-  read.csv( p,   header=FALSE, sep=" ",  comment.char = "#",  quote = "\"", stringsAsFactors=FALSE)





#1c) read the measurement data and inject corresponding subject and activity identifiers
trainMatrix <- readAndProcessMeasurements(
  trainPath, nFeaturesPlusSubjectCount , XtrainLineCount , trainSubjectsRead, trainActivityRead )
testMatrix <- readAndProcessMeasurements( 
  testPath, nFeaturesPlusSubjectCount , XtestLineCount , testSubjectsRead, testActivityRead )
#1d) trainMatrix  and testMatrix
combinedMatrixReadyForColumnNames <- rbind( trainMatrix, testMatrix)

# The combinedMatrixReadyForColumnNames satisfies step 1 of this assignment.


#2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# The readAndProcessFeatures() function this also deposits a mapping from old to new names
## into the variable (in this scope), featureNameMapNewToOld.
## This is intended for use in the Read.me documentation.

#2a) read, tidy-up, and inject appropriate column names into the combinedMatrixReadyForColumnNames.
cleanColumnNamesNew  <- readAndProcessFeatures()

colnames( combinedMatrixReadyForColumnNames ) <- cleanColumnNamesNew

#2b) remove any duplicate-named columns, in anticipation of possible errors in the  next step
combinedMatrixNoDuplicateColumns <- combinedMatrixReadyForColumnNames [ , !duplicated(colnames(combinedMatrixReadyForColumnNames ))]

#2c) remove the columns not pertaining to mean and standard deviation (keep mean and std: u or s
combinedMatrix <- combinedMatrixNoDuplicateColumns[ , grepl( "[us]|Subject|Activity", colnames(combinedMatrixNoDuplicateColumns))]


#3. Uses descriptive activity names to name the activities in the data set

#3a) read the activity labels
p <- file.path( featuresDir, "activity_labels.txt")
labelLines <-  readLines( p)

#3b) make a look-up table from the label code (index) to label names
labelLinesLabelsOnly <-  gsub("[0-9 ]+", "", labelLines)
labelNumberToNameDataTable <- data.table(labelLinesLabelsOnly)

# FYI example lookup label from number code fix the  nested type structure that R chose for the series of strings)
w <- unname( unlist( labelNumberToNameDataTable[2]))


combinedMatrixActivity <- combinedMatrix  #matrix( nrow=nrow(combinedMatrix), ncol=ncol(combinedMatrix))




# integrate the activity label data with the training matrix, using the presently-empty second column
for ( i in 1:nrow(combinedMatrix))  {
  n <- combinedMatrixActivity[ i, "Activity"]
  if (grepl("[0-9]", n)) {
    combinedMatrixActivity[ i, "Activity"] <- unname( unlist(labelNumberToNameDataTable[ as.numeric(n)]))
  }
}


for ( i in 1:nrow(combinedMatrixActivity))  {
  for (j in 3:ncol(combinedMatrixActivity))
    combinedMatrixActivity[ i, j] <- as.numeric(combinedMatrixActivity[ i, j])
}



#4. Appropriately labels the data set with descriptive variable names. 

combinedMatrixActivity[1:3,1:5]
## Subject Activity   tBa-X-u          tBa-Y-u           tBa-Z-u          
## [1,] "1"     "STANDING" "2.8858451e-001" "-2.0294171e-002" "-1.3290514e-001"
## [2,] "1"     "STANDING" "2.7841883e-001" "-1.6410568e-002" "-1.2352019e-001"
## [3,] "1"     "STANDING" "2.7965306e-001" "-1.9467156e-002" "-1.1346169e-001"


Activities <- c("WALKING",
                "WALKING_UPSTAIRS",
                "WALKING_DOWNSTAIRS",
                "SITTING",
                "STANDING",
                "LAYING"                )

Subjects <- 1:30

 tidyColumnNames <-  cleanColumnNamesNew[2:length(cleanColumnNamesNew)]
 tidyColumnNames[1] <- "Subject_Activity"



tidy <- matrix(  nrow=length(Activities)* length(Subjects),  ncol=length(tidyColumnNames))



#activityAndSubject <- "Subject_Activity"

colnames(tidy) <- tidyColumnNames

mat <- combinedMatrixActivity

for ( activity in Activities) {
  for ( subject in Subjects) {
    activityAndSubject <- unname(unlist( paste(subject,activity)))
    for (column in tidyColumnNames) { #TODO: column names
      if (column != "Subject_Activity") {
        tidy[ tidy[ ,1]==activityAndSubject , column] <- 
          mean(  as.numeric( mat[mat[ ,1]==subject & mat[, 2]==activity, column]), na.rm=TRUE)
        
        tidy[ tidy$Subject_Activity==activityAndSubject , column] <- 
          mean( mat[ mat$Subject==subject & mat$Activity==activity, column], na.rm=TRUE)
        
      }
    }
  }
}






#5. From the data set in step 4, creates a second, independent
## tidy data set
## with the average of each variable for each activity and each subject.


# initialize new combined file
resultsDir <- "getdata_projectfiles_UCI HAR Dataset"
p <- file.path( resultsDir, "combinedTrainingAndTestData.txt")

df <- as.data.frame( matTrainWithSubjectColumn)




#TODO: if you saved the file with write.table according to the instructions, the command for reading it in and looking at it in R would be
data <- read.table(file_path, header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
View(data)
to make life easy for their marker would give the code for reading the file back into R in the readMe. 

Go back to quiz 1 and look at the codebook there for inspiration.

quiz 3 on reshaping - regarding step 4 of this project.




https://class.coursera.org/getdata-030/forum/thread?thread_id=266
Hi everyone. I have got the tidy data set as per step 5. However, my write.table function is giving a text file which is unreadable, instead of a neat and tidy dataset. The last line of my script is:
  write.table(df,"./df.txt", row.name=FALSE)
Any suggestions on what I am doing wrong?
Also, since the file is on my computer, will the link work when my fellow students are grading my project?
Thanks!
  David HoodCommunity TA? 2 hours ago 㼿
That is as expected. Tidy means easy for computers to process, not pleasing to the human eye. Anyone marking the project has, by definition done the project, and is capable of using read.txt("file", header=TRUE)

---------------
  
  
  
  
  > # Compute the average (median miles per gallon and horsepower of each automobile manufacturer)
  > dataset <- data.frame(manufacturer = c("chevrolet", "chevrolet", "dodge", "dodge", "ford", "ford"), model = c("suburban", "sierra", "ram 2500", "ram 1500", "f150", "f250"), mpg = c(5, 7, 10, 8, 5, 6), hp = c(125, 115, 250, 150, 135, 225))
> dataset
manufacturer    model mpg  hp
1    chevrolet suburban   5 125
2    chevrolet   sierra   7 115
3        dodge ram 2500  10 250
4        dodge ram 1500   8 150
5         ford     f150   5 135
6         ford     f250   6 225
> d <- melt(data = dataset, 
            +         id=c("manufacturer"), 
            +         measure.vars = colnames(dataset[,grep("mpg|hp",colnames(dataset))]))
> d
manufacturer variable value
1     chevrolet      mpg     5
2     chevrolet      mpg     7
3         dodge      mpg    10
4         dodge      mpg     8
5          ford      mpg     5
6          ford      mpg     6
7     chevrolet       hp   125
8     chevrolet       hp   115
9         dodge       hp   250
10        dodge       hp   150
11         ford       hp   135
12         ford       hp   225
> d <- dcast(d, manufacturer ~ variable, median)
> d
manufacturer mpg  hp
1    chevrolet 6.0 120
2        dodge 9.0 200
3         ford 5.5 180



