# JSON API spørring til SSB

# SOK-1301 Forelesning 6
# Måling av ulikhet


rm(list=ls()) 

library(rjstat)
library(httr)
library(tidyverse)

url <- "https://data.ssb.no/api/v0/no/table/07756/"

query <- '{
  "query": [
    {
      "code": "Forbruksenhet2",
      "selection": {
        "filter": "item",
        "values": [
          "01",
          "99"
        ]
      }
    },
    {
      "code": "ContentsCode",
      "selection": {
        "filter": "item",
        "values": [
          "Ginikoeffisient",
          "P90P10",
          "S80S20"
        ]
      }
    }
  ],
  "response": {
    "format": "json-stat2"
  }
}'

hent_indeks.tmp <- url %>%
  POST(body = query, encode = "json")

df <-  hent_indeks.tmp %>%
  content("text") %>%
  fromJSONstat() %>%
  as_tibble()



