#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Ngram Prediction Model"),
  sidebarPanel(
    textInput(inputId = "word1", label = "Input Word1"),
    textInput(inputId = "word2", label = "Input Word2"),
    textInput(inputId = "word3", label = "Input Word3"),
    actionButton("goButton", "Press Go! (Press again if result is NA.)")
  ),
  mainPanel(
    p('Quadrigram: Word1, Word2, Word3, Word4 (lower case)'),
    textOutput('quadrigram')
  ) 
))
