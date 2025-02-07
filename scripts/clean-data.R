library(tidyverse)


# height ------------------------------------------------------------------
data <- read_csv("data/data-raw/NHANES Weight and Height.csv")
data |> 
  janitor::clean_names() |> 
  select(-1) |> 
  saveRDS(file = "data/height.rds")


# income ------------------------------------------------------------------

map(LETTERS[1:3], ~read_csv(glue::glue("data/data-raw/2021Census_G17{.x}_AUS_AUS.csv"))) |> 
  reduce(left_join, by = "AUS_CODE_2021") |> 
  select(-1) |> 
  pivot_longer(everything(), names_to = "name", values_to = "count") |> 
  filter(!str_detect(name, "Tot")) |> 
  filter(!str_detect(name, "PI_NS")) |> 
  filter(!str_detect(name, "Nil_in")) |> 
  filter(str_detect(name, "^P")) |> 
  mutate(name = str_replace(name, "_yrs$", "")) |>
  mutate(name = str_replace(name, "ov$", "+_ ")) |>
  mutate(name = str_replace(name, "_more", "+_ ")) |>
  separate(col = name, into =  c("sex", "income_min", "income_max", "age_min", "age_max"), sep = "_") |> 
  mutate(income = str_c(str_c("$", income_min), income_max, sep = "-")) |> 
  summarise(n = sum(count), .by = c(income, income_min)) |> 
  mutate(income = str_remove(income, "- $"),
         p = n / sum(n),
         income_min = parse_number(income_min)) |> 
  mutate(income = fct_inorder(income)) |>
  saveRDS(file = "data/income.rds")


# food prices -------------------------------------------------------------

data <- read_csv("data/data-raw/wfp_food_prices_ind.csv") |> 
  mutate(date = mdy(date),
         year = year(date), 
         month = month(date)) |> 
  filter(commodity == "Wheat flour",
         year == 2022, month == 4) |> 
  janitor::remove_constant()
  
  
data |> 
  saveRDS(file = "data/wheat-retail-prices.rds")


# R packages --------------------------------------------------------------

db <- available.packages() |> 
  as.data.frame()

bin_size <- 500
nbin <- floor(nrow(db) / bin_size) + 1
pkg_split <- split(db$Package, rep(1:nbin, each = bin_size)[1:nrow(db)])

# time consuming

data <- map_dfr(pkg_split, ~{
  cranlogs::cran_downloads(from = "2024-02-01", to = "2024-02-28", packages = .x)
})
saveRDS(distinct(data), file = "data/cranlogs.rds")

cranlogs <- readRDS("data/cranlogs.rds") |> 
  summarise(count = sum(count), .by = package) 
