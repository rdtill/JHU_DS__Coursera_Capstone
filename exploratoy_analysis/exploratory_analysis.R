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
  
  if(files[i] != 'en_US.twitter.txt') {                       #histogram of character counts by file (ISSUE 2)
    hist_char[[i]] = hist(tmp_char, plot = FALSE,      
                          breaks = seq(from = 0, 
                                       to = ceiling(max(tmp_char) / 20) * 20, 
                                       by = 20))
  } else {
    hist_char[[i]] = hist(tmp_char, plot = FALSE)
  }
  if(files[i] != 'en_US.twitter.txt') {                       #histogram of word counts by file (ISSUE 2)
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
  
  remove(tmp_file, tmp_char, tmp_word, tmp_wcnt, tmp_prof, file_keep)
  
  if(i == length(files)){print('Processing complete')}
}

#sumdf_char = rbind(summ_char[[1]], summ_char[[2]], summ_char[[3]])
#ownames(sumdf_char) = files
#sumdf_word = rbind(summ_word[[1]], summ_word[[2]], summ_word[[3]])
#rownames(sumdf_word) = files

#blogs = read_lines(files[1])
#prof_blg = blogs[inde_prof$en_US.blogs.txt]
#tmp_char = sapply(blogs, nchar)
#tmp_char = as.vector(tmp_char)
#p = ggplot() + geom_histogram(data = tmp_char)

#####
# ISSUES:
#
#   1   Profanity count only considers one-word profanities.  Need to add code to
#       consider profanities that are > 1 word.
#             - profanity filter may be flawed, only returned 'xx' and 'xxx' for the blog entries
#               that contained profantiy
#
#   2   Word count and character count histograms contain outliers that convolude the 
#       visualization. Need to add code to remove
#
#   3   