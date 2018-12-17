#####
#    installing packages
#####
library(NLP)
library(readr)
library(stringr)
library(ggplot2)

setwd('C:\\Users\\tillr\\Coursera\\Capstone\\project\\functions')
source('functions.R')

file_keep <- TRUE

set.seed(1234)

#####
#    ngram generation
#####
#reference data
setwd('C:\\Users\\tillr\\Coursera\\Capstone\\project\\ref_dat')
#setwd('C:\\Users\\User\\Desktop\\Coursera\\Data Science Specialization\\Capstone\\ref_dat')
prof_en    = read_lines('prof_en.txt')

setwd('C:\\Users\\tillr\\Coursera\\Capstone\\final\\en_US')
#setwd('C:\\Users\\User\\Desktop\\Coursera\\Data Science Specialization\\Capstone\\final\\en_US')
#character & word count summary
files    = dir()
bigrams  = list()
trigrams = list()
for(i in 1:length(files)) {
  print(paste('Processing ', files[i], sep = ''))
  
  tmp_file = read_lines(files[i])
  if(file_keep) {
    if(i == 1){blog <- tmp_file}
    if(i == 2){news <- tmp_file}
    if(i == 3){twtr <- tmp_file}
  }
  
  five_perc = sample(1:100, length(tmp_file), replace = TRUE) < 6
  tmp_dat = tmp_file[five_perc]
  
  #bigrams
  tmp_grams = list()
  for(j in 1:length(tmp_dat)) {
    tmp_grams[[j]] = my_ngram(txt = tmp_dat[j], n = 2)
  }
  bigrams[[i]] = tmp_grams
  remove(tmp_grams)
  
  #trigrams
  tmp_grams = list()
  for(j in 1:length(tmp_dat)) {
    tmp_grams[[j]] = my_ngram(txt = tmp_dat[j], n = 3)
  }
  trigrams[[i]] = tmp_grams
  
  names(bigrams)[i]  = files[i]
  names(trigrams)[i] = files[i]
  
  remove(tmp_file, tmp_dat, tmp_grams)
  
  if(i == length(files)){print('Processing complete')}
}
setwd('C:\\Users\\tillr\\Coursera\\Capstone\\project\\ngram generation\\ngrams')
save(bigrams, file = "bigrams.Rdata")
save(trigrams, file = "trigrams.Rdata")



#####
# ISSUES:
#
#   1   Profanity count only considers one-word profanities.  Need to add code to
#       consider profanities that are > 1 word.
#             - profanity filter may be flawed, only returned 'xx' and 'xxx' for the blog entries
#               that contained profantiy
#
#   3   