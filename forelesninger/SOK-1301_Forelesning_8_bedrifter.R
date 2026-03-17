# JSON API spørring til SSB

# SOK-1301 Forelesning 8
# Bedrifter i Tromsø


rm(list=ls()) 

library(rjstat)
library(httr)
library(tidyverse)

url <- "https://data.ssb.no/api/v0/no/table/07091/"

query <- '{
  "query": [
    {
      "code": "Region",
      "selection": {
        "filter": "agg:KommSummer",
        "values": [
          "K-5501"
        ]
      }
    },
    {
      "code": "NACE2007",
      "selection": {
        "filter": "item",
        "values": [
          "01-99",
          "01",
          "02",
          "03",
          "05",
          "06",
          "07",
          "08",
          "09",
          "10",
          "11",
          "12",
          "13",
          "14",
          "15",
          "16",
          "17",
          "18",
          "19",
          "20",
          "21",
          "22",
          "23",
          "24",
          "25",
          "26",
          "27",
          "28",
          "29",
          "30",
          "31",
          "32",
          "33",
          "35",
          "36",
          "37",
          "38",
          "39",
          "41",
          "42",
          "43",
          "45",
          "46",
          "47",
          "49",
          "50",
          "51",
          "52",
          "53",
          "55",
          "56",
          "58",
          "59",
          "60",
          "61",
          "62",
          "63",
          "64",
          "65",
          "66",
          "68",
          "69",
          "70",
          "71",
          "72",
          "73",
          "74",
          "75",
          "77",
          "78",
          "79",
          "80",
          "81",
          "82",
          "84",
          "85",
          "86",
          "87",
          "88",
          "90",
          "91",
          "92",
          "93",
          "94",
          "95",
          "96",
          "97",
          "99",
          "00"
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

# filtrer for år 2025

df_2025 <- df %>% filter(år == 2025)

# hent ut tallet som viser totalt antall bedrifter

total_bedrifter <- df_2025 %>% 
  filter(`næring (SN2007)` == "Total") %>% 
  pull(value)

# regn ut prosent av totalt antall bedrifter

df_2025 <- df_2025 %>%
  filter(`næring (SN2007)` != "Total") %>%
  mutate(prosent = (value / total_bedrifter) * 100)

# lag plott

df_2025 %>% 
  ggplot(aes(x = `næring (SN2007)`, y = prosent)) +
  geom_bar(stat = "identity", fill = "green") +
  theme_minimal() +
  labs(title = "Andel av bedrifter etter næring, Tromsø kommune 2025",
       x = "Næring",
       y = "Prosent %") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

