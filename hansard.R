# File: hansard.R
# Description: Generate plot and publish to twitter
# Author: Noel Dempsey
# Date: 2018-12-02

# Imports ---------------------------------------------------------------------

library(tidyverse)
library(rvest)
library(tidytext)
library(tm)
library(ggplot2)
library(ggwordcloud)
library(twitteR)

setwd("C:/Users/Noel/Documents/R/projects/hansard")
source("utility/hansard_functions.R")

# Main ------------------------------------------------------------------------

# Twitter API
setup_twitter_oauth(consumer_key = "YOUR KEY",
                    access_token = "YOUR KEY",
                    consumer_secret = "YOUR KEY",
                    access_secret = "YOUR KEY")

# Check if latest sitting day is new
x <- as.tibble(hansard_date())
y <- read_tsv("check.txt", col_names = "value",
              col_types = cols(.default = "c"))

if (str_detect(x$value, y$value) == FALSE) { 
  
  # If new run script
  source("utility/hansard_plot.R") 

# Tweet plot
updateStatus(paste("Word cloud for", x),
              mediaPath = paste("output/", x, ".png", sep = ""))
    
}