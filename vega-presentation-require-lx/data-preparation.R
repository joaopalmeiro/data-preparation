library(tidyverse)
library(here)
library(HistData)
library(readxl)
library(emo)

rose_data <- as_tibble(Nightingale)
rose_data

rose_data <-
  rose_data %>% select(Month, Year, Disease, Wounds, Other)
rose_data

rose_data <- rose_data %>%
  pivot_longer(-c(Month, Year), names_to = "cause", values_to = "n_deaths")  %>% rename_all(tolower)
rose_data

# write_csv(rose_data, here("data", "rose_data.csv"))

names_m <-
  readr::read_csv("./raw-data/nomesmasculino.csv", locale = locale(encoding = "latin1"))
names_m <-
  names_m %>% mutate(gender = "M") %>% select(-`KeyYear-Gender`) %>% rename_all(tolower) %>% rename(name = nome)
names_m


names_f <-
  readr::read_csv("./raw-data/nomesfeminino.csv", locale = locale(encoding = "latin1"))
names_f <-
  names_f %>% mutate(gender = "F") %>% select(-`KeyYear-Gender`) %>% rename_all(tolower) %>% rename(name = nome)
names_f

names <- bind_rows(names_f, names_m)
names

# write_csv(names, here("data", "names.csv"))

operations <-
  read_excel("./raw-data/abril2020-lisbonmunicipality-alloperations-value.xlsx",
             skip = 4)
operations
operations <- operations %>% select(Sector, Amount)
operations

operations <- operations %>% add_column(
  emoji = c(
    emo::ji_find("shopping")[[2,2]],
    emo::ji_find("building")[[1,2]],
    emo::ji_find("box")[[5,2]],
    emo::ji("pill"),
    emo::ji_find("phone")[[4,2]],
    emo::ji_find("location")[[1,2]],
    emo::ji_find("shopping")[[1,2]],
    emo::ji_find("computer")[[1,2]],
    emo::ji_find("hospital")[[1,2]],
    emo::ji_find("box")[[1,2]]
  )
) %>% rename_all(tolower)
operations

# write_csv(operations, here("data", "operations.csv"))
