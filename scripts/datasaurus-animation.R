library(datasauRus)
library(ggplot2)
library(gganimate)
g <- datasaurus_dozen |> 
  ggplot(aes(x=x, y=y))+
  geom_point()+
  theme_minimal(base_size = 24) +
  transition_states(dataset, 3, 1) 
g  


g2 <- datasaurus_dozen |> 
  mutate(cor = cor(x, y),
         meanx = mean(x),
         meany = mean(y),
         sdx = sd(x),
         sdy = sd(y),
         text = glue::glue("r: {cor}\nmean x: {meanx}\nmean y: {meany}\nsd x: {sdx}\nsd y: {sdy}"),
         .by = dataset) |> 
  ggplot(aes(x=x, y=y))+
  geom_point(color = "white") + 
  geom_text(aes(label = text), x = 20, y = 90, hjust = 0, vjust = 1,
            data = ~. |> slice(1, .by = dataset), 
            color = "black", size = 8) +
  theme_void(base_size = 24) +
  transition_states(dataset, 3, 1) 
g2

anim_save(here::here("images/datasaurus.gif"), g, width = 600, height = 600)
anim_save(here::here("images/datasaurus-text.gif"), g2, width = 400, height = 400)
