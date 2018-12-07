#####
#    installing packages
#####
library(NLP)
library(readr)

#####
#    exploratory analysis
#####
#reference data
setwd('C:\\Users\\tillr\\Coursera\\Capstone\\project\\ref_dat')
#setwd('C:\\Users\\User\\Desktop\\Coursera\\Data Science Specialization\\Capstone\\ref_dat')
prof_en    = read_lines('prof_en.txt')

setwd('C:\\Users\\tillr\\Coursera\\Capstone\\final\\en_US')
#setwd('C:\\Users\\User\\Desktop\\Coursera\\Data Science Specialization\\Capstone\\final\\en_US')
#character & word count summary
files     = dir()
summ_char = list()
summ_word = list()
cont_prof = list()
inde_prof = list()
hist_char = list()
hist_word = list()
line_cont  = list()
for(i in 1:length(files)) {
  print(paste('Processing ', files[i], sep = ''))
  
  tmp_file            = read_lines(files[i])
  tmp_char            = sapply(tmp_file, nchar)
  tmp_word            = lapply(tmp_file, FUN = function(txt) {
                          splt_txt  = strsplit(txt, " ")
                          list(len  = length(splt_txt[[1]]), 
                               prof = sum(is.element(prof_en, splt_txt)))
                        })
  tmp_wcnt            = sapply(tmp_word, FUN = function(ele) { 
                          ele$len  
                        })
  tmp_prof            = sapply(tmp_word, FUN = function(ele) { 
                          ele$prof  
                        })
  
  summ_char[[i]]      = summary(tmp_char)   #summary of character count per line
  summ_word[[i]]      = summary(tmp_wcnt)   #summary of word count per line
  cont_prof[[i]]      = sum(tmp_prof)       #total count of profanities in file (NOTE 1)
  inde_prof[[i]]      = which(tmp_prof > 0) #lines that contain profanities by file (NOTE 1)
  hist_char[[i]]      = hist(tmp_char)      #histogram of character counts by file (NOTE 2)
  hist_word[[i]]      = hist(tmp_wcnt)      #histogram of word counts by file (NOTE 2)
  line_cont[[i]]      = length(tmp_file)    #line count by file
  
  names(summ_char)[i] = files[i]
  names(summ_word)[i] = files[i]
  names(cont_prof)[i] = files[i]
  names(inde_prof)[i] = files[i]
  names(hist_char)[i] = files[i]
  names(hist_word)[i] = files[i]
  names(line_cont)[i] = files[i]
  
  remove(tmp_file, tmp_char, tmp_word, tmp_wcnt, tmp_prof)
  
  if(i == length(files)){print('Processing complete')}
}

#tmp_file = read_lines(files[1])
#tmp_file = tmp_file[1:10]
#tmp_word = lapply(tmp_file, FUN = function(txt) {
#  splt_txt  = strsplit(txt, " ")
#  list(len  = length(splt_txt[[1]]), 
#       prof = sum(is.element(prof_en, splt_txt)))
#})
#
#test_len  = sapply(tmp_word, FUN = function(ele) { 
#  ele$len  
#})
#test_prof = sapply(tmp_word, FUN = function(ele) { 
#  ele$prof  
#})



#####
# NOTES:
#
#   1   Profanity count only considers one-word profanities.  Need to add code to
#       consider profanities that are > 1 word.
#
#   2   Word count and character count histograms contain outliers that convolude the 
#       visualization. Need to add code to remove
#
#   3   