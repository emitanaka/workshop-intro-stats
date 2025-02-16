library(tidyverse)
theme_set(theme_void())

tibble(x = 0:1) |> 
  mutate(y = dbinom(x, 1, 0.45)) |> 
  ggplot(aes(x, y)) +
  geom_col()# +
  #geom_text(data = data.frame(x = 0:1, y = 0.05, label = c("Success", "Failure")), 
  #          aes(x, y, label = label), color = "white", size = 10) +
  #geom_text(data = data.frame(x = 0:1, y = 0.3, label = c("p", "1 – p")), 
  #          aes(x, y, label = label), color = "white", size = 8)

ggsave("images/dist-bernoulli.svg", width = 2, height = 2, dpi = 300)


tibble(x = 0:5) |> 
  mutate(y = dbinom(x, 5, 0.3)) |> 
  ggplot(aes(x, y)) +
  geom_col() 

ggsave("images/dist-binomial.svg", width = 2, height = 2, dpi = 300)


tibble(x = seq(-5, 5, 0.001)) |> 
  mutate(y = dnorm(x, 0, 1)) |> 
  ggplot(aes(x, y)) +
  geom_ribbon(aes(ymin = 0, ymax = y))

ggsave("images/dist-normal.svg", width = 2, height = 2, dpi = 300)


tibble(x = seq(-5, 5, 0.001)) |> 
  mutate(y = dt(x, 10)) |> 
  ggplot(aes(x, y)) +
  geom_ribbon(aes(ymin = 0, ymax = y))

ggsave("images/dist-t.svg", width = 2, height = 2, dpi = 300)
