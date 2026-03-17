# SOK-1301 Forelesning 5

# Produksjon i Norge 

# Data fra SSB, tabell 09171
# Produksjon i basisverdi.2. kvartal 2025. Faste 2022-priser (mill. kr)
# Basisverdi er prisen selgeren mottar for varen, uten mva og avgifter med evt subsidier.


# rydd

rm(list=ls())

# last inn pakken
library(tidyverse)



# URL (csv fil)
url <- "https://raw.githubusercontent.com/uit-sok-1301-h25/uit-sok-1301-h25.github.io/main/data/prod_f5.csv"

# last inn fila

df <- read.csv(url, header = FALSE)
#df <- read.csv("prod_f5.csv", header = FALSE)

# endre kolonnenavn

df <- df %>%
  rename(Næring = V1, Verdi = V2)

################
#  OPPGAVE    #
################

# 1 Bruk geom_bar() i ggplot 2 for å lage en stolpediagram av produksjonsverdier for hver næring
# 2 Er det lett å tolke denne visualiseringen? Hva kan gjøres for å forbedre den?

