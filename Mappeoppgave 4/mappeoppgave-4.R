library(tidyverse)
library(rvest)
library(rlist)

#henter data og lager en liste med disse
link <-list("https://timeplan.uit.no/emne_timeplan.php?sem=22v&module%5B%5D=SOK-1005-1&week=1-20&View=list",
            "https://timeplan.uit.no/emne_timeplan.php?sem=22v&module%5B%5D=SOK-2001-1&View=list",
            "https://timeplan.uit.no/emne_timeplan.php?sem=22v&module%5B%5D=SOK-2030-1&View=list")

#lager en funksjon som leser og skraper dataen
data <- function(link) {
  return(d <- read_html(link) %>%   #leser data
          html_nodes(., 'table') %>%  #henter liste
          html_table(., fill=TRUE) %>% 
          list.stack(.) %>%
          set_names(slice(., 1)) %>%  # setter første rad til navn på kolonne 
          filter(!Dato=="Dato") %>%    # velger vekk alle kolonner med "Dato" i
          separate(Dato, 
                    into = c("Dag", "Dato"),   # deler dato i to
                    sep = "(?<=[A-Za-z])(?=[0-9])") %>% 
           .[-length(.$Dag),] %>%
           mutate(Dato = as.Date(Dato, format = "%d.%m.%Y")) %>% # endrer til dato format
           drop_na() %>%   # dropper manglende observasjoner
           select(Dag,Dato,Lærer,Tid,Rom,Emnekode,Beskrivelse)) # velger kolonner
  }

data <- map(link, data) %>%   # bruker map til å få funksjonen til å lese datan
  list.stack(.)  # brukes for å få en dataframe

data3



