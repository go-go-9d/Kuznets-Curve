
#make gdp_tidy
country_gdp <- function(URL, country){
  data <- read.csv(URL)
  data$country <- country
  return(data)
}
gdp_jpn <- country_gdp("02_raw/gdp/data/Japan.csv", "JPN")
gdp_usa <- country_gdp("02_raw/gdp/data/United States.csv", "USA")

gdp_tidy <- rbind(gdp_jpn,gdp_usa)
