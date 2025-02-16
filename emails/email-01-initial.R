library(Microsoft365R)
library(blastula)
library(glue)
library(tidyverse)
participant_emails <- read_csv(here::here("emails/participants.csv")) |> 
  pull(Email)

outlook <- get_business_outlook()
email <- compose_email(body = md(glue('Hi there,<br><br>
  
Thank you for registering for the workshop **Introduction to Statistics with R**.

The workshop will be online via Zoom on **Tue 18th and Wed 19th Feburary 2025** on the following times for both days:

- _Perth_ timezone: 8.00am - 1.45pm with one hour break (9.30am - 10.30am),  
- _Brisbane_ timezone: 10.00am - 3.45pm with one hour break  (11.30am - 12.30pm),  
- _Adelaide_ timezone: 10.30am - 4.15pm with one hour break (12.00pm - 1.00pm), and
- _Sydney/Canberra/Melbourne_ timezone: 11.00am - 4.45pm with one hour break (12.30pm - 1.30pm).

The zoom link to join the meeting can be found [**here**](https://us05web.zoom.us/j/85660423517?pwd=bdlRYfdpHm6laAmlvXcngR57xY617R.1).
I will be shortly sending through a Calendar invite with the zoom link. 

## Preparation 

Please ensure that you have:

- a computer or laptop with a stable (and preferably fast) internet connection, and
- a modern web browser like [Google Chrome](https://www.google.com/chrome/).
- You may like to have an extra monitor so you can watch the workshop on one screen and code on the other.


In this workshop, all R code and exercises are run in the browser using Quarto live. 
As such, **you don\'t need to install R or any R packages to participate in this workshop**. But should you wish to know the R packages used in the workshop, these include:
                                        
```r
c("tidyverse", "ggdist", "ggbeeswarm", "broom", "patchwork", "GGally", "ggpubr",
  "emmeans", "modelsummary", "ggResidpanel", "agridat", "faraway", "abd")
```

I\'ll provide the link to the workshop website closer to the date (and don\'t worry all materials will continue to be available after the workshop).

The workshop expects that you are familiar with R, tidyverse and basic numerical and graphical summaries (e.g. mean, standard deviation, boxplot, and histogram). 
If you require a refresher, I recommend the following resources:

- [R for Data Science (2e)](https://r4ds.hadley.nz/), 
- [Exploratory Data Analysis with R](https://bookdown.org/rdpeng/exdata/) and
- [An interactive introduction to data analysis with R](https://learnr.numbat.space/).

Talk more and see you on Zoom next week!  
  
<br>
Best,<br><br>
  
Emi Tanaka')))

email

outlook$create_email(body = email,
                     content_type = "html",
                     bcc = c(participant_emails, "alex.whan@csiro.au"),
                     subject = "Introduction to Statistics with R Workshop - Zoom Link and Preparation",)



