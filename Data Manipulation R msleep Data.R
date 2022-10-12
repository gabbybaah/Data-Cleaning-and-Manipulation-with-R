# Loading libraries

library(tidyverse)

# View Data
glimpse(msleep)

# Rename a variable
msleep %>% 
  rename("conserv" = "conservation")

# Reorder Variables
msleep %>% 
  select(vore, name, everything())

# Change a variable Type
class(msleep$vore)

msleep$vore <- as.factor(msleep$vore)

msleep %>% 
  mutate(vore = as.character(vore)) %>% 
  glimpse()

# Selecting variables to work with
names(msleep)

msleep %>% 
  select(2:4,
         awake, 
         starts_with("sleep"),
         contains("wt")) %>% 
  names()


# Filter and Arranging data
unique(msleep$order)

msleep %>% 
  filter((order == "carnivora" |
          order == "primates") &
           sleep_total > 8) %>% 
  select(name, order, sleep_total) %>% 
  arrange(-sleep_total) %>% 
  View()

msleep %>% 
  filter(order %in% c("carnivora", "Primates") &
           sleep_total >8) %>% 
  select(name, order, sleep_total) %>% 
  arrange(order) %>% 
  View()


# Change Observations (mutate)
msleep %>% 
  mutate(brainwt = brainwt * 1000) %>% 
  View()

msleep %>% 
  mutate(brainwt_in_grams = brainwt * 1000) %>% 
  View()

# Conditional Changes (if_else)

msleep$brainwt
msleep$brainwt > 0.01

size_of_brain <- msleep %>% 
  select(name, brainwt) %>% 
  drop_na(brainwt) %>% 
  mutate(brain_size = if_else(brainwt > 0.01,
                              "large","small"))

size_of_brain


# Recoding and Renaming a Variable

size_of_brain %>% 
  mutate(brain_size = recode(brain_size,
                             "large" = 1, "small" = 2))

# Data Reshaping from wide to long and vice versa

install.packages("gapminder")
library(gapminder)
View(gapminder)

data <- select(gapminder, country, year, lifeExp)
View(data)

wide_data <- data %>% 
  pivot_wider(names_from = year, values_from = lifeExp)

View(wide_data)

long_data <- wide_data %>% 
  pivot_longer(2:13,
               names_to = "year",
               values_to = "lifeExp")
View(long_data)



# Summarizing Data 

min(msleep$awake)
max(msleep$awake)
range(msleep$awake)
IQR(msleep$awake)
mean(msleep$awake)
median(msleep$awake)
var(msleep$awake)

summary(msleep)
summary(msleep$sleep_total)

msleep %>% 
  select(sleep_total, brainwt) %>% 
  summary()

# Creating summary table

msleep %>% 
  drop_na(vore) %>% 
  group_by(vore) %>% 
  summarise(lower = min(sleep_total),
            Average = mean(sleep_total),
            Upper = max(sleep_total),
            Difference = max(sleep_total)-min(sleep_total)) %>% 
  arrange(Average) %>% 
  View()


# Creating Contingency Tables

install.packages("MASS")
library(MASS)
attach(Cars93)

glimpse(Cars93)

table(Origin)
table(AirBags, Origin)
addmargins(table(AirBags, Origin),1) 
#add a sum of values below each column = 1, sum roles = 2, sum both = 3

table(AirBags, Origin)
prop.table(table(AirBags, Origin),2)*100
round(prop.table(table(AirBags, Origin),2)*100) # remove decimals


Cars93 %>% 
  group_by(Origin, AirBags) %>% 
  summarise(number = n()) %>% 
  pivot_wider(names_from = Origin,
              values_from = number)

  
  