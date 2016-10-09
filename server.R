quadrigram <- function(Word1, Word2, Word3) {
  word1 <- tolower(Word1)
  word2 <- tolower(Word2)
  word3 <- tolower(Word3)

library(readr)
blogs <- sample(read_lines("C:/Users/d2i2k/Documents/en_US/blogs.txt"), 2000, replace=FALSE, prob=NULL)
blogs2 <- grep("blogs", iconv(blogs, "latin1", "ASCII", sub="blogs"))
blogs3 <- blogs[-blogs2]
news <- sample(read_lines("C:/Users/d2i2k/Documents/en_US/news.txt"), 150, replace=FALSE, prob=NULL)
news2 <- grep("news", iconv(news, "latin1", "ASCII", sub="news"))
news3 <- news[-news2]
twitter <- sample(read_lines("C:/Users/d2i2k/Documents/en_US/twitter.txt"), 5000, replace=FALSE, prob=NULL)
twitter2 <- grep("twitter", iconv(news, "latin1", "ASCII", sub="twitter"))
twitter3 <- twitter[-twitter2]
library(tm)
corpus <- VCorpus(VectorSource(paste(blogs3, news3, twitter3)))
corpus <- tm_map(corpus, content_transformer(function(x) iconv(enc2utf8(x), sub="byte")))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, c("a","about","above","after","again","against","all","an","and","any","are","as","at","be","because","been","before","being","below","between","both","but","by","did","do","does","doing","down","during","each","few","for","further","had","has","have","having","he","her","hers","herself","him","his","himself","his","how","i","if","in","into","is","it","its","itself","like","me","more","most","my","myself","no","not","nor","of","on","once","one","only","or","other","our","out","our","ours","ourselves","out","over","own","same","she","so","some","such","than","that","the","their","theirs","these","them","themselves","then","they","this","those","through","to","too","under","until","up","very","was","we","were","what","when","where","which","while","who","whom","will","with","why","you","your","yours","yourself","yourselves"))

# Quadrigrams (n=4)

library(RWeka)
BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min=4, max=4))
tdm4 <- TermDocumentMatrix(corpus, control = list(tokenize = BigramTokenizer))
freq4 <- sort(rowSums(as.matrix(tdm4),), decreasing=TRUE)
  result <- names(freq4[grep(paste(word1,word2,word3,""), names(freq4))])[1]
  return(result)
}

#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyServer(
  function(input, output) {
    output$quadrigram <- renderText({
  if (input$goButton == 0) "You have not pressed Go!"
      else if ((input$goButton == 1)) "Press again if result is NA"
  isolate(quadrigram(input$word1, input$word2, input$word3))
  })
 }
)
