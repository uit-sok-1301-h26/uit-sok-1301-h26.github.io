# JSON API spørring til SSB

# SOK-1301 Forelesning 8
# Internasjonal handel

# Hent data fra SSBs tabell 10482

rm(list=ls()) 

library(rjstat)
library(httr)
library(tidyverse)

url <- "https://data.ssb.no/api/v0/no/table/10482/"

query <- '{
  "query": [
    {
      "code": "Region",
      "selection": {
        "filter": "item",
        "values": [
          "0",
          "31",
          "32",
          "30",
          "01",
          "02",
          "03",
          "34",
          "04",
          "05",
          "33",
          "06",
          "39",
          "40",
          "38",
          "07",
          "08",
          "42",
          "09",
          "10",
          "11",
          "46",
          "12",
          "14",
          "15",
          "50",
          "16",
          "17",
          "18",
          "55",
          "56",
          "54",
          "19",
          "20",
          "21",
          "22",
          "NVFF",
          "PUDT",
          "99"
        ]
      }
    },
    {
      "code": "SITC",
      "selection": {
        "filter": "item",
        "values": [
          "SITCT",
          "SITC0-1",
          "SITC03u",
          "SITC2_4",
          "SITC3b",
          "SITC5",
          "SITC6",
          "SITC7+9",
          "SITC8"
        ]
      }
    },
    {
      "code": "Tid",
      "selection": {
        "filter": "item",
        "values": [
          "2024"
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

# her er det mange 0 verdier pga at fylket ikke eksisterer i 2024
# vi fjerner disse

df <- df %>% 
  filter(value != 0)


# vi velger ut kun noen fylker

utvalgte_regioner <- c(
  "Oslo",
  "Viken",
  "Innlandet",
  "Vestfold og Telemark",
  "Agder",
  "Rogaland",
  "Vestland",
  "Møre og Romsdal",
  "Trøndelag - Trööndelage",
  "Nordland - Nordlánnda",
  "Troms - Romsa - Tromssa"
)

df_utvalgt <- df %>% 
  filter(region %in% utvalgte_regioner)



# OPPGAVE 1. Bruk df_utvalgt og lag en stolpediagram som viser "Varer i alt" for hvert fylke

## Svar her



# OPPGAVE 2. Nå skal du plotte alle varegruppene for hvert fylke. 
# Vi tar først bort "Forskjellige ferdigvarer" og "Varer i alt"

df_utvalgt_ny <- df_utvalgt %>% 
  filter(varegruppe != "Forskjellige ferdigvarer", varegruppe != "Varer i alt")

# HINT: vi bruker facet_wrap(~ varegruppe) for å få en graf per varegruppe

## Svar her

# Vi ser at det er en varegruppe som heter "¬ Fisk" som er en undergruppe av "Matvarer, drikkevarer, tobakk"
# Vi kan endre navnet på denne varegruppen til "Matvarer, drikkevarer, tobakk (Fisk)"

df_endelig <- df_utvalgt_ny %>% 
  mutate(varegruppe = ifelse(varegruppe == "¬ Fisk", "Matvarer, drikkevarer, tobakk (Fisk)", varegruppe))

# OPPGAVE 3. Tegn samme figur som i oppgave 2 ved å bruke df_endelig.
# Denne gangen skal du bruke facet_wrap(~ varegruppe, scales = "free_y")
# Hva skjer?

## Svar her
