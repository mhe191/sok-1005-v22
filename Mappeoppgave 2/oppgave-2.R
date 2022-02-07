library(tidyverse)
library(rjson)
# Sammerbeidet med Martin og Andre

#Oppgave 1
data <- fromJSON(file = "https://static01.nyt.com/newsgraphics/2021/12/20/us-coronavirus-deaths-2021/ff0adde21623e111d8ce103fedecf7ffc7906264/scatter.json")
data_df <- do.call(rbind.data.frame, data) 

 
data_df %>% 
  select(state = name, fully_vaccinated = fully_vaccinated_pct_of_pop, deaths_per_100k ) %>% 
  ggplot(aes(x=fully_vaccinated, y=deaths_per_100k, label=state)) + 
  geom_point(color="cadetblue3") + 
  geom_text(hjust=0, vjust=2, size=2) +
  theme_bw() + 
  labs(x="Share of total population fully vaccinted", 
       y="20 avg. monthly deaths per 100,000") +
  ggtitle("Covid-19 deaths since universal adult vaccine eligibility compared with 
          \n vaccination rates ") +
  scale_x_continuous(labels = scales::percent, 
                     breaks = seq(from = 0, to = 1, by=0.05)) +
  annotate("text", x=0.73, y=9, label= "Higher vaccination rate, \n lower death rate", size=3.5) +
  annotate("text", x=0.59, y=16, label= "Lower vaccination rate, \n higher death rate", size=3.5)

#Plotet viser sammenhengen mellom antall døde per 100 000 i 
#USA og graden av vaksinerte i landet. Det kommer frem i plotet 
#at vakrinering har stor effekt på å ungå død. Høyere grad av vaksinering, 
#gir lavere dødstall.


#Oppgave 2
lm(fully_vaccinated_pct_of_pop ~ deaths_per_100k, data = data_df) 

#Funksjonen brukes til å regne linær regresjon av daten. 
#Tallene vi får fra funksjonen viser oss sammenhengen mellom vaksinasjon og dødsraten.
#-0,01655 sier hvor mye dødstallene synker for hver prosent økning i vaksinasjongrad.
#Det vil si at 1% høyere vaksinasjonsgrad vil gi 0,01655 mindre døde per 100 000

data_df %>% 
  select(state = name, fully_vaccinated = fully_vaccinated_pct_of_pop, deaths_per_100k ) %>% 
  ggplot(aes(x=fully_vaccinated, y=deaths_per_100k, label=state)) + 
  geom_point(color="cadetblue3") + 
  geom_text(hjust=0, vjust=2, size=2) +
  theme_bw() + 
  geom_smooth(method = lm) +
  labs(x="Share of total population fully vaccinted", y="20 avg. monthly deaths per 100,000") +
  ggtitle("Covid-19 deaths since universal adult vaccine eligibility compared with \n vaccination rates ") +
  scale_x_continuous(labels = scales::percent, breaks = seq(from = 0, to = 1, by=0.05))

#Grafen viser linær regresjon av dataene, som vil gi en fallende kurve

 



