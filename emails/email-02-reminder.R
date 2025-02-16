library(Microsoft365R)
library(blastula)
library(glue)
library(readxl)
participant_emails <- read_excel(here::here("emails/2024-09-25 CPD-184 Introduction to Large Language Models for Statisticians Statistical Society of Au.xls")) |> 
  dplyr::pull(Email)

outlook <- get_business_outlook()
email <- compose_email(body = md(glue("Hi everyone,<br><br>
                                        
                                      **Introduction to Large Language Models for Statisticians** workshop, hosted by The Statistical Society of Australia, will be held online via Zoom today (Tue 15th Oct 2024, 1:30PM - 4:45PM AEDT).
                                      Please note that you should have an email and calendar invite with an optional preparation instruction from me last Tuesday.
                                      <br>
                                      
                                      **Pre-Workshop Support**<br>
                                      I'll be logging in at 1:15 PM AEDT to help you check your Zoom connection or address any other issues. Feel free to reach out beforehand if you have any concerns.
                                      <br>
                                      
                                      **Zoom Link**<br>
                                      To join the meeting, click on this [**link**](https://anu.zoom.us/j/84006753763?pwd=r2db3GCPVaREKB8gnMoZ3E2z1gGEaz.1&from=addon).
                                      
                                      <br>
                                      
                                      **Workshop website**<br>
                                      
                                      For the workshop materials, visit the website [**here**](https://emitanaka.org/workshop-LLM-2024). 
                                      
                                      <br>
                                      
                                      **Software Installation Update**<br>
                                      
                                      If you have already prepared with software installation, 
                                      please note that there has been numerous updates to the `elmer` package in the past week.
                                      Unfortunately, one result of this is that the chat for Ollama models has [some bug](https://github.com/hadley/elmer/issues/117) now.
                                      As a result, it will be better to re-install the package using the previous version instead. 
                                      To do this, please run the following code in your R console:
                                      
                                      ```
                                      install.packages(\"pak\")
                                      pak::pak(\"emitanaka/elmer\")
                                      ```
                                      
                                      Looking forward to meeting you online soon!
                                        
                                      <br>
                                      Best,<br><br>
                                        
                                      Emi Tanaka")))

email

outlook$create_email(body = email,
                     content_type = "html",
                     bcc = participant_emails,
                     subject = "Materials for SSA Workshop: Introduction to Large Langauge Models for Statisticians")



