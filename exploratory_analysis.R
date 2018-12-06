#####
#    installing packages
#####
library(NLP)
library(readr)

#####
#    exploratory analysis
#####
#reference data
setwd('C:\\Users\\User\\Desktop\\Coursera\\Data Science Specialization\\Capstone\\ref_dat')
prof_en    = read_lines('prof_en.txt')

#setwd('C:\\Users\\tillr\\Coursera\\Capstone\\data\\en_US')
setwd('C:\\Users\\User\\Desktop\\Coursera\\Data Science Specialization\\Capstone\\final\\en_US')
#character & word count summary
files      = dir()
summ_char  = list()
summ_word = list()
for(i in 1:length(files)) {
  print(paste('    Processing ', files[i], sep = ''))
  
  tmp_file        = read_lines(files[i])
  tmp_char        = sapply(tmp_file, nchar)
  tmp_word        = sapply(tmp_file, FUN = function(txt) {
                      length(strsplit(txt, " ")[[1]])
                    })
  summ_char[[i]]  = summary(tmp_char)
  summ_word[[i]]  = summary(tmp_word)
  names(summ_char)[i] = files[i]
  names(summ_word)[i] = files[i]
  
  remove(tmp_file, tmp_char, tmp_word)
}


