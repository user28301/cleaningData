# Step 1 - Merge training and test data set

subject <- rbind (read.table ("train/subject_train.txt"),
                  read.table ("test/subject_test.txt"))
x <- rbind (read.table ("train/X_train.txt"),
            read.table ("test/X_test.txt"))
y <- rbind (read.table ("train/y_train.txt"),
            read.table ("test/y_test.txt"))

# Step 2 - Extract columns for mean and std only

features <- read.table ("features.txt")
columnsWanted <- grep ("mean\\(\\)|std\\(\\)", tolower (features [,2]))
x <- x [, columnsWanted]
# also update feature names, so we don"t need columnsWanted
features <- features [columnsWanted, 2]
remove (columnsWanted)

# Step 3 - Load in the activity and use it to transform y
activity <- read.table ("activity_labels.txt")
y <- merge (activity, y, by.x = 1, by.y = 1)
activity <- y [,2]
remove (y) # do not need that anymore

# Step 4 - Transform feature names to make it more readable
# first remove parentheses
features <- gsub ("\\(", "", features)
features <- gsub ("\\)", "", features)
# change starting "t" to "timing.", and starting "f" to "freq."
features <- gsub ("^t", "timing\\.", features)
features <- gsub ("^f", "freq\\.", features)
# change all "-" to "." for consistency
features <- gsub ("-", "\\.", features)
# and put a "." between words
features <- gsub ("([a-z])([A-Z])", "\\1\\.\\2", features)
# then convert all letter to lowercase
features <- tolower (features)
# some name have two 'body' appear together, this
# probably is a typo, so fix it
features <- gsub ("body\\.body", "body", features)

# Finally apply the transformed names to data
names (x) <- features
names (subject) <- c ("subject.id")

# Step 5 - create a tidy data set and write it out
tidy <- cbind (subject, x, activity)
remove (subject, x, activity)
write.table (tidy, file = "tidy.data.txt", row.name = FALSE)

# create code book from features
features = c ("subject.id", features, "activity")
desc <- gsub ("\\.", " ", features)
desc <- gsub ("freq", "frequency", desc)
desc <- gsub ("acc", "acceleration", desc)
desc <- gsub ("^([^ ]*) (.*)mean", "average \\1 data for \\2", desc)
desc <- gsub ("^([^ ]*) (.*)std", "standard deviation of \\1 data for \\2", desc)
desc <- gsub ("(x|y|z)$", "in \\1 direction", desc)
desc <- gsub ("for (.*) mag", "for magnitude of \\1", desc)
desc <- gsub ("  ", " ", desc)
desc <- gsub ("activity", "the activity the subject is performing", desc)
desc <- gsub ("subject id", "id of the subject", desc)
desc <- paste (c (1:68), ". ", features, " - ", desc, sep="")
desc <- c ("###There are a total of 68 fields in the data:", "", desc)

write.table (desc, "CodeBook.md", row.names=FALSE, col.names=FALSE, quote=FALSE)
remove (features, desc)
