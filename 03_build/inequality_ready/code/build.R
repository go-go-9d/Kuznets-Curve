#make inequality_ready
#separate data by country and fill in "country" column
inequality_separate <- function(inequality_tidy, country){
  data <- as.tibble(inequality_tidy[inequality_tidy$country == country, ])
  data <- data %>%
    complete(year = full_seq(year, 1))
  data[,2] <- paste0(country)
  return(data)
}

inequality_jpn <- inequality_separate(inequality_tidy, "JPN")
inequality_usa <- inequality_separate(inequality_tidy, "USA")
view(inequality_jpn)
view(inequality_usa)

#complement NA with linear regression
inequality_linear <- function(data, option, start_num){
  linear_data <- na_interpolation(data, option = option)
  linear_data <- linear_data %>%
    slice(seq(start_num,length(data$year),5))
  return(linear_data)
}
inequality_jpn_linear <- inequality_linear(inequality_jpn, "linear", 1)
view(inequality_jpn_linear)
inequality_usa_linear <- inequality_linear(inequality_usa, "linear", 2)
view(inequality_usa_linear)


inequality_ready <- rbind(inequality_jpn_linear, inequality_usa_linear)
view(inequality_ready)