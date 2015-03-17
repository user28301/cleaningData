# cleaningData
For the course project in the coursera course "Getting and Cleaning Data"

There are three (3) files in this repo:

1. README.md - this file
2. CodeBook.md - the code book
3. run_analysis.R - the script for cleaning the data

Here we assume that the data has been downloaded and saved.
The R working directory has been set to the top level data folder
The resulting clean data set will be written to this top level
folder with the name "tidy.data.txt".

Note that the R script also creates the code book file.

To obtain the tidy data set, simply run this script and the data
set will be created and saved.

To see the created data, you can use one of the following command
to load the data: either

- tidy <- read.table ("tidy.data.txt", header=TRUE)

or

- tidy <- read.csv ("tidy.data.txt", sep=" ")

after the data is loaded, you can use the following command
to see the data in R-studio:

- View (tidy)

or use one (or both) the following commands to see a portion of the data in the console:

- head (tidy) # to see the first 6 records
- tail (tidy) # to see the last 6 records
