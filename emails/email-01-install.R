library(Microsoft365R)
library(blastula)
library(glue)
library(readxl)
participant_emails <- read_excel(here::here("emails/2024-09-25 CPD-184 Introduction to Large Language Models for Statisticians Statistical Society of Au.xls")) |> 
  dplyr::pull(Email)

outlook <- get_business_outlook()
email <- compose_email(body = md(glue("Hi there,<br><br>
                                        
                                      Thank you for registering for the Statistical Society of Australia workshop: 
                                      
                                      **Introduction to Large Language Models for Statisticians**.
                                      
                                      The workshop will be online via Zoom on **Tue 15th October 2024 1.30PM - 4.45PM AEDT**.
                                      
                                      The zoom link to join the meeting can be found [**here**](https://anu.zoom.us/j/84006753763?pwd=r2db3GCPVaREKB8gnMoZ3E2z1gGEaz.1&from=addon).
                                      
                                      ### Preparation (Optional)
                                      
                                      Please note, as per the workshop description, that some may experience technical difficulties in 
                                      setting up the required software. Unfortunately, we will not have time to troubleshoot these issues 
                                      during the workshop (and I cannot replicate OS-specific issues easily). 
                                      
                                      One way to overcome any technical 
                                      issues is to access large language models (LLMs) via an application programming interface (API). This 
                                      requires an account with a vendor and a small payment to use their services (~US$5 is more than sufficient).
                                      For this demonstration, I will use LLMs by OpenAI (the vendor behind one of the most well-known chatbots, `chatGPT`).
                                      If you would like to follow along with this approach, please sign up for an account with OpenAI [here](https://platform.openai.com/signup)
                                      and add a small credit to your account (make sure auto recharge is off to avoid unexpected charges).
                                      
                                      I will predominately demonstrate applications using local LLMs via Ollama. 
                                      This approach requires _no payment_ as well as no internet access after you download/pull the LLM.
                                      You do require sufficient RAM to use these models locally (at least 16GB for 13b models), so it is preferable to use a more powerful computer.
                                      
                                      To follow the code demonstrations on your own computer, please make sure to install the following software before the start of the workshop.
                                      
                                      - [R](https://cran.r-project.org/)
                                      - An Integrated Development Environment (IDE) for R such as [RStudio](https://www.rstudio.com/products/rstudio/download/)
                                      - [Ollama](https://ollama.com/download)
                                      - The following R packages by running the commands below in the R console:
                                      ```
                                      install.packages(c('pak', 'usethis', 'tidyverse'))
                                      pak::pak(\"hadley/elmer\") # or use pak::pak(\"emitanaka/elmer\") if not working
                                      pak::pak(\"emitanaka/SAI\")
                                      pak::pak(\"AlbertRapp/tidychatmodels\") # backup
                                      ```
                                      
                                      
                                      In addition, download at least one local LLM. Please note that these **_local LLMs are large (several GB) and may take some time (>10 minutes) to download_**.
                                      I will mainly use `llama3.1:8b` which can be downloaded/pulled by using the command below in the _terminal_ (not the R console):
                                      
                                      ```
                                      ollama pull llama3.1:8b
                                      ```
                                      
                                      If you do not have a large RAM (<8GB), you may try a smaller model such as `llama3.2:1b` (but its output may not be as accurate):
                                      
                                      ```
                                      ollama pull llama3.2:1b
                                      ```
                                      
                                      To check that ollama is installed properly, open a terminal and start ollama. 

                                      ```
                                      ollama serve
                                      ```

                                      Check the version of ollama.

                                      ```
                                      ollama --version
                                      ```
                                      
                                      Talk more and see you on Zoom next week!  
                                        
                                      <br>
                                      Best,<br><br>
                                        
                                      Emi Tanaka")))

email

outlook$create_email(body = email,
                     content_type = "html",
                     cc = "events@statsoc.org.au",
                     bcc = participant_emails,
                     subject = "SSA Workshop: Introduction to Large Langauge Models for Statisticians")



