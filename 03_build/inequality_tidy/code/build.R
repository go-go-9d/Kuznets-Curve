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