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

source("utility/hansard_functions.R")
source("utility/auth.R")

# Main ------------------------------------------------------------------------

# Twitter API authentication
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# Check if latest sitting day is new
x <- enframe(hansard_date(), name = NULL)
y <- read_tsv("check.txt", col_names = "value",
              col_types = cols(.default = "c"))

if (str_detect(x$value, y$value) == FALSE) { 
  
  # If new run script
  source("utility/hansard_plot.R") 

# Tweet plot
updateStatus(paste("Word cloud for", x),
              mediaPath = paste("output/", x, ".png", sep = ""))
    
}
