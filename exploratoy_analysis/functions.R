#functions that are sourced in exploratory_analysis.R

library(NLP)

# my_ngram
#
#     This is a simple extension on the ngrams function from
#     the NLP package.
#
#   Args: 
#     - txt:    a character value
#     - split:  what character txt is split by
#     - n:      how many words are used to form the n-gram (1, 2, 3, etc.)
#
my_ngram <- function(txt, split, n) {
  ngrams(strsplit(txt, split)[[1]], n)
}