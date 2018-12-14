#####
#    installing packages
#####
library(NLP)
library(readr)
library(ggplot2)

setwd('C:\\Users\\tillr\\Coursera\\Capstone\\project\\exploratoy_analysis')
source('functions.R')

file_keep <- TRUE

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
sdev_char = list()
sdev_word = list()
cont_prof = list()
inde_prof = list()
hist_char = list()
hist_word = list()
line_cont = list()
avgw_leng = list()
for(i in 1:length(files)) {
  print(paste('Processing ', files[i], sep = ''))
  
  tmp_file = read_lines(files[i])
  tmp_char = sapply(tmp_file, nchar)
  tmp_word = lapply(tmp_file, FUN = function(txt) {
               splt_txt  = strsplit(txt, " ")[[1]]
               list(len  = length(splt_txt), 
                    prof = sum(is.element(prof_en, splt_txt)), 
                    avwl = mean(nchar(splt_txt)))
             })
  tmp_wcnt = sapply(tmp_word, FUN = function(ele) { 
               ele$len  
             })
  tmp_prof = sapply(tmp_word, FUN = function(ele) { 
               ele$prof  
             })
  tmp_wlen = sapply(tmp_word, FUN = function(ele) {
               ele$avwl
             })
  
  summ_char[[i]] = summary(tmp_char)                          #summary of character count per line
  summ_word[[i]] = summary(tmp_wcnt)                          #summary of word count per line
  sdev_char[[i]] = sd(tmp_char)                               #standard deviation of character count
  sdev_word[[i]] = sd(tmp_wcnt)                               #standard deviation of word count
  cont_prof[[i]] = sum(tmp_prof)                              #total count of profanities in file (ISSUE 1)
  inde_prof[[i]] = which(tmp_prof > 0)                        #lines that contain profanities by file (ISSUE 1)
  
  if(files[i] != 'en_US.twitter.txt') {                       #histogram of character counts by file
    hist_char[[i]] = hist(tmp_char, plot = FALSE,      
                          breaks = seq(from = 0, 
                                       to = ceiling(max(tmp_char) / 20) * 20, 
                                       by = 20))
  } else {
    hist_char[[i]] = hist(tmp_char, plot = FALSE)
  }
  if(files[i] != 'en_US.twitter.txt') {                       #histogram of word counts by file
    hist_word[[i]] = hist(tmp_wcnt, plot = FALSE,      
                          breaks = seq(from = 0, 
                                       to = ceiling(max(tmp_wcnt) / 10) * 10, 
                                       by = 10))
  } else {
    hist_word[[i]] = hist(tmp_wcnt, plot = FALSE)
  }
  
  line_cont[[i]] = length(tmp_file)                           #line count by file
  avgw_leng[[i]] = summary(tmp_wlen)                          #summary of average word length by file
  
  names(summ_char)[i] = files[i]
  names(summ_word)[i] = files[i]
  names(sdev_char)[i] = files[i]
  names(sdev_word)[i] = files[i]
  names(cont_prof)[i] = files[i]
  names(inde_prof)[i] = files[i]
  names(hist_char)[i] = files[i]
  names(hist_word)[i] = files[i]
  names(line_cont)[i] = files[i]
  names(avgw_leng)[i] = files[i]
  
  if(file_keep) {
    if(i == 1){blog <- tmp_file}
    if(i == 2){news <- tmp_file}
    if(i == 3){twtr <- tmp_file}
  }
  
  remove(tmp_file, tmp_char, tmp_word, tmp_wcnt, tmp_prof)
  
  if(i == length(files)){print('Processing complete')}
}


#####
#    n-gram generation
#####

#bigrams
five_perc = sample(1:100, length(blog), replace = TRUE) < 6
bigrams = list()
tmp_dat = blog[five_perc]
for(i in 1:length(tmp_dat)) {
  bigrams[[i]] = my_ngram(txt = tmp_dat[i], n = 2)
}


#####
# ISSUES:
#
#   1   Profanity count only considers one-word profanities.  Need to add code to
#       consider profanities that are > 1 word.
#             - profanity filter may be flawed, only returned 'xx' and 'xxx' for the blog entries
#               that contained profantiy
#
#   3   