# File: hansard_plot.R
# Description: Download hansard file and generate word cloud
# Author: Noel Dempsey
# Date: 2018-12-05

# Load data
data <- hansard_file()

# Remove number characters 
data <- removeNumbers(data$`Commons Chamber`)
data <- as.tibble(data)

# Remove NA
data <- na.omit(data)

# Remove all non alpha
data <- str_replace_all(data, "[^[:alnum:]]", " ")
data <- as.tibble(data)

# Tokenize
data <- data %>% unnest_tokens(word, value)

# Load stop words
data(stop_words)
source("utility/hansard_words.R")

# Remove stop words
data <- data %>% 
  filter(!word %in% stop_words$word) %>%
  filter(!word %in% mp_first_stop_words$word) %>%
  filter(!word %in% mp_last_stop_words$word) %>%
  filter(!word %in% parly_stop_words$word) %>%
  filter(!word %in% party_stop_words$word) %>%
  filter(!word %in% month_stop_words$word)

# Count words
data <- data %>% count(word, sort = TRUE)

# Top 100
data <- data[1:100,]

# Create word cloud
plot <- hansard_plot()

# Save file
ggsave(hansard_name(), width = 15.87, height = 8.86, units = "cm")

# Write sitting date
fileConn <- file("check.txt")
writeLines(hansard_date(), fileConn)
close(fileConn)