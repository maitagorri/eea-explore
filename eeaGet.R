
require(httr)
require(tidyjson)

eeaGet <- function(query){
  # a function to less painfully query the EEA emissions database
  tryCatch(return({
    GET("https://discodata.eea.europa.eu/sql",
        query = list(query=query))%>%
      content(as="parsed") %>%
      (function(x){x$results}) %>%
      spread_all
  }), error = function(e){print(paste("problem retrieving",query))})
}

queryDistinct <- function(var){
  # function to get distinct values of a given variable in a dataset
  query = paste0("SELECT DISTINCT [", 
                 var,
                 "] FROM [CO2Emission].[latest].[co2cars]")
  print(query)
  tryCatch(return (eeaGet(query) %>% pull(var)), error = function(e){print(paste("problem retrieving",var))})
}