library(tidyverse)

View(gapminder)

gapminder %>% 
  filter(continent %in% c("Africa", "Europe")) %>% 
  filter(gdpPercap < 30000) %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp, size =pop, color = year))+
  geom_point()+
  facet_wrap(~continent)+
  labs(title = "Life Expectancy Explained by GDP per Capita",
       x = "GDP per Capita",
       y = "Life Expectancy")