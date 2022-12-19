# make gdp_ready
country_gdp_per_capita <- function(data, GDP, population){
  process_data <-data
  process_data$GDP_per_capita <- process_data$GDP / process_data$population
  return(process_data)
}
gdp_ready <- country_gdp_per_capita(gdp_tidy, GDP, population)
view(gdp_ready)