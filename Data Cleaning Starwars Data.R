# install packages
library(tidyverse)
View(starwars)

# Variable Types
glimpse(starwars)
class(starwars$gender)
unique(starwars$gender)

starwars$gender <- as.factor(starwars$gender)
class(starwars$gender)

# finding the order of data in a column
levels(starwars$gender)

# Reordering 
starwars$gender <- factor((starwars$gender), levels = c("masculine", "feminine"))


# Selecting Variables

names(starwars)

starwars %>% 
  select(name, height, ends_with("color")) 


# Filtering different Observations
unique(starwars$hair_color)

starwars %>% 
  select(name, height, ends_with("color")) %>% 
  filter(hair_color %in% c("blond", "brown") & height < 180)


# Missing Data

mean(starwars$height, na.rm = TRUE)

starwars %>% 
  select(name, gender, hair_color, height)

# Removing missing data
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  na.omit()

# Showing selected columns with missing data
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.))

# Dropping missing data in a column
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>% 
  drop_na(height)

# Replacing N/A values with a word or object (overwriting)
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>% 
  mutate(hair_color = replace_na(hair_color, "none"))
  # mutate(hair_color2 = replace_na(hair_color, "none")) =new column


# Duplicates
Names <- c("Peter", "John", "Andrew", "Peter")
Age <- c(22, 33, 44, 22)

friends <- data.frame(Names, Age)

# Showing non-duplicates
friends[!duplicated(friends),]

friends %>%  distinct()

# Recoding Variables (replacing variables with numbers or letters)
starwars %>% select(name, gender)

starwars %>% 
  select(name,gender) %>% 
  mutate(gender = recode(gender, "masculine" = 1, "feminine" = 2))
