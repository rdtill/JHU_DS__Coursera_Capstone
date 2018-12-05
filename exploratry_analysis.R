#initial exploratory analysis
setwd('C:\\Users\\tillr\\Coursera\\Capstone\\data\\en_US')

#reading files
files = dir()

blogs   = readLines(files[1], skipNul = TRUE)
news    = readLines(files[2], skipNul = TRUE)
twitter = readLines(files[3], skipNul = TRUE)

