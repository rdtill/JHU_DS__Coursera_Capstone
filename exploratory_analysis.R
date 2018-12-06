#initial exploratory analysis
#setwd('C:\\Users\\tillr\\Coursera\\Capstone\\data\\en_US')
setwd('C:\\Users\\User\\Desktop\\Coursera\\Data Science Specialization\\Capstone\\final\\en_US')

library(NLP)
library(readr)

#    reading in data
#####
#raw data
dat_blogs   = read_lines('en_US.blogs.txt')
dat_news    = read_lines('en_US.news.txt')
dat_twitter = read_lines('en_US.twitter.txt')
#reference data
setwd('C:\\Users\\User\\Desktop\\Coursera\\Data Science Specialization\\Capstone\\ref_dat')
prof_en    = read_lines('prof_en.txt')


