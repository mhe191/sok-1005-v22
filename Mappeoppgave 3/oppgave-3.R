library(tidyverse)
library(rvest)
library(dplyr)

# Sammarbeidet med Andre Langvik og Martin Smedstad

# Oppgave 1:
# Henter data:

data <- read_html("https://www.motor.no/aktuelt/motors-store-vintertest-av-rekkevidde-pa-elbiler/217132")

# Henter ut tabellen fra filen:
tabell <- data %>% 
html_node("body") %>% 
  html_table(header = TRUE)

# Rydder opp:
tabell <- tabell %>% 
  select(model = starts_with("Modell"), wltp_tall = starts_with("WLTP"),
         stopp = STOPP, avvik = Avvik) %>%  #Velger kolonner og endrer navn
  slice((1:(n()- 34))) %>%    #fjerner unødvenig data
  slice(-c(19, 26)) %>% 
  mutate_at("stopp", str_replace, "km", "") %>%   #fjerner benevninger
  mutate_at("avvik", str_replace, "%", "") %>% 
  separate(wltp_tall, sep = "/", into=c("wltp","kWh")) %>% #deler kollone i to
  mutate_at("wltp", str_replace, "km", "") %>%  
  mutate_at("kWh", str_replace, "kWh", "") %>% 
  mutate(avvik = str_replace(avvik, ",", "."),      #endrer desimalskille fra ,
         kWh = str_replace(kWh, ",", "."))          # til .

#Ender til numeric   
tabell$stopp <- as.numeric(tabell$stopp) 
tabell$wltp <- as.numeric(tabell$wltp)
tabell$kWh <- as.numeric(tabell$kWh)
tabell$avvik <- as.numeric(tabell$avvik) 

str(tabell)


# Plotter modellen
plot <- tabell %>% 
  ggplot(aes(x=wltp, y=stopp)) +
  geom_point() + 
  theme_classic() + 
  scale_x_continuous(breaks = seq(from = 200, to = 600, by=100), 
                     limits = c(200, 650)) +
  scale_y_continuous(breaks = seq(from = 200, to = 600, by=100),
                     limits = c(200, 650)) +
  labs(x="Wltp (oppgitt kjørelengde)", 
       y="Stopp (faktisk kjørelengde)",
       title = "Forhold mellom oppgitt og faktisk kjørelengde") +
  geom_abline(size = 1, col  ="red")

plot
  
#Bruker tabellen fra https://www.motor.no/aktuelt/motors-store-vintertest-av-rekkevidde-pa-elbiler/217132 
#til å lage et plot som viser forholdet mellom wltp, som er beregnet kjørelengde, 
#og faktisk kjørelengde. I plottet har jeg lagt til en 45° 
#linje som viser hvor langt bilene egentlig skulle ha kjørt. 
#Det vi ser i plottet er at alle bilene lverer dårligere 
#rekkevidde en det som står oppført. Jo lengre vekk fra linjen jo større er 
#gapet mellom beregnet og faktisk kjørelengde.  


#oppgave 2:

#bruker lm() funksjonen 

lm(stopp ~ wltp, data = tabell)

#Benytter lm-funksjonen til å finne forholdet mellom wltp og stopp. 
#Vi får da en postiiv sammenheng, som vil si at høyere wltp, 
#vil gi lengre kjørelengde. Ut fra regresjons analysen ser vi at en økning 
#på 1 km i oppgitt kjørelengde (wltp), vil gi en økning på 0,86 km på faktisk 
#kjørelengde (stopp). Noe som vil si at faktisk kjørelengde vil være omtrent 
#86% av oppgitt kjørelengde.


#legger til i plottet

plot + geom_smooth(method = lm)

#Plotter inn den linære regresjonen i plottet, og får en ny linje

#Kilder:
https://dplyr.tidyverse.org/reference/rename.html
https://datascience.stackexchange.com/questions/15589/remove-part-of-string-in-r
https://www.statology.org/character-to-numeric-in-r/






