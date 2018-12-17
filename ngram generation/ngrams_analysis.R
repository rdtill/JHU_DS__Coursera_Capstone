#####
#    installing packages
#####
library(NLP)
library(readr)
library(stringr)
library(ggplot2)

setwd('C:\\Users\\tillr\\Coursera\\Capstone\\project\\functions')
source('functions.R')


#####
#    loading and processing bigrams
#####
setwd('C:\\Users\\tillr\\Coursera\\Capstone\\project\\ngram generation\\ngrams')
load("bigrams.Rdata")

#blogs
bi_blog = lapply(bigrams$en_US.blogs.txt, FUN = function(ele) {
  if(length(ele) != 0) {
    for(i in 1:length(ele)) {
      if(i == 1) {
        output = data.frame(first = ele[[i]][1], second = ele[[i]][2])
      } else {
        output = rbind(output, data.frame(first = ele[[i]][1], second = ele[[i]][2]))
      }
    }
    output
  } else {
    0
  }
})
for(i in 1:length(bi_blog)) {
  
}
bi_df = 0
for(i in 1:length(bi_blog)) {
  if(is.data.frame(bi_blog[[i]])) {
    if(!is.data.frame(bi_df)) {
      bi_df = bi_blog[[i]]
    } else {
      bi_df = rbind(bi_df, bi_blog[[i]])
    }
  }
}

#news
# bi_news = lapply(bigrams$en_US.news.txt, FUN = function(ele) {
#   if(length(ele) != 0) {
#     for(i in 1:length(ele)) {
#       if(i == 1) {
#         output = data.frame(first = ele[[i]][1], second = ele[[i]][2])
#       } else {
#         output = rbind(output, data.frame(first = ele[[i]][1], second = ele[[i]][2]))
#       }
#     }
#     output
#   } else {
#     0
#   }
# })
# 
# #twtr
# bi_twtr = lapply(bigrams$en_US.twitter.txt, FUN = function(ele) {
#   if(length(ele) != 0) {
#     for(i in 1:length(ele)) {
#       if(i == 1) {
#         output = data.frame(first = ele[[i]][1], second = ele[[i]][2])
#       } else {
#         output = rbind(output, data.frame(first = ele[[i]][1], second = ele[[i]][2]))
#       }
#     }
#     output
#   } else {
#     0
#   }
# })



#####
#    loading and processing trigrams
#####
#load("trigrams.Rdata")