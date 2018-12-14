#functions that are sourced in exploratory_analysis.R

library(NLP)

# my_ngram
#
#     This is a simple extension on the ngrams function from
#     the NLP package.
#
#   Args: 
#     - txt:    a character value
#     - n:      how many words are used to form the n-gram (1, 2, 3, etc.)
#
#   Notes:
#     - the current regular expression used to extract words is listed below.
#
#             "[[:alpha:]]*['|-]?[[:alpha:]]*[^ [[:punct:]]]"
my_ngram <- function(txt, n) {
  text = str_extract_all(txt, "[[:alpha:]]*['|-]?[[:alpha:]]*[^ [[:punct:]]]", simplify = FALSE)[[1]]
  ngrams(text, n)
}






