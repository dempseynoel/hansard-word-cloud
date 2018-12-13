# File: hansard_functions.R
# Description: Functions to generate hansard word cloud
# Author: Noel Dempsey
# Date: 2018-12-05

hansard_main <- function() {
  
  page <- read_html("https://hansard.parliament.uk/commons/latestsittingday")
  path <- str_c('//*[@id="main"]/div[2]/div[3]/div/div[3]/div[2]',
                '/div/ul/li/a[text() = "Commons Chamber"]')
  full <- html_attr(html_node(page, xpath = path), "href")
  
}

hansard_page <- function() {
  
  base <- "https://hansard.parliament.uk"
  page <- hansard_main()
  full <- paste(base, page, sep = "")
  
}

hansard_file <- function() {
  
  base <- "https://hansard.parliament.uk"
  page <- read_html(hansard_page())
  path <- '//*[@id="main"]/div[2]/div[1]/div[1]/div[1]/div/ol/li[2]/div/a'
  full <- html_attr(html_node(page, xpath = path), "href")
  file <- paste(base, full, sep = "")
  
  # Download file
  data <- read_tsv(file, col_types = cols(.default = "c"))
  
}

hansard_date <- function() {
  
  day <- hansard_main() %>% 
    str_sub(start = 15, end = 24)

}

 hansard_hexs <- function() {
  
  colours <- c("#A3586D", "#5C4A72", "#F3B05A", "#F4874B", "#F46A4E",
               "#6C6B74", "#2E303E", "#9199BE", "#54678F", "#5C3D46",
               "#5C868D", "#99BFAA", "#C8D6CA", "#253F5B", "#4F728E")
  colours<- sample(colours, 5)
  
}

hansard_plot <- function() {
  
  plot <- ggplot(data, aes(label = word, size = n, colour = word)) +
    geom_text_wordcloud_area(shape = "square", rm_outside = TRUE) +
    scale_size_area(max_size = 20) +
    theme_minimal() +
    theme(plot.margin=grid::unit(c(0,0,0,0), "mm")) +
    scale_colour_manual(values = rep(hansard_hexs(), 20))

}

hansard_name <- function() {
  
  day <- hansard_date()
  day <- paste("output/", day, ".png", sep = "")
  
}