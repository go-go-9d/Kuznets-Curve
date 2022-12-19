#make gdp_tidy
country_gdp <- function(URL, country){
  data <- read.csv(URL)
  data$country <- country
  return(data)
}
gdp_jpn <- country_gdp("02_raw/gdp/data/Japan.csv", "JPN")
gdp_usa <- country_gdp("02_raw/gdp/data/United States.csv", "USA")

gdp_tidy <- rbind(gdp_jpn,gdp_usa)

#make gdp_ready
country_gdp_per_capita <- function(data, GDP, population){
  process_data <-data
  process_data$GDP_per_capita <- process_data$GDP / process_data$population
  return(process_data)
}
gdp_ready <- country_gdp_per_capita(gdp_tidy, GDP, population)
view(gdp_ready)

#make inequality_tidy
inequality_gini <- function(URL, gini, year){
  data <- read.xlsx(URL)
  t_data <- as.data.frame(t(data))
  colnames(t_data) <- t_data[1, ] 
  t_data <- t_data[-1, ] 
  t_data$gini <- as.numeric(t_data$gini)
  t_data$year <- as.integer(t_data$year)
  process_data <- t_data
  return(process_data)
}

inequality_tidy <- inequality_gini("02_raw/inequality/data/Gini.xlsx",gini,year)
view(inequality_tidy)

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

#make master
master <- left_join(gdp_ready, inequality_ready)
view(master)
