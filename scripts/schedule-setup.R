ex_tabset <- function(id) {
  paste0("[_Exercise ", id, "_](#tabset-1-", id, "-tab){onclick=",
         'document.getElementById(', "'tabset-1-", id, "-tab').click();",
         '}')
}

slide_title <- function(id) {
  paste0("[", 
         rmarkdown::yaml_front_matter(paste0("slides/slide", id, ".qmd"))$title,
         "](slides/slide", id, ".html){target='_blank'}")
}

# LOs <- readLines("/slides/_learning-objectives.qmd")
# LOs <- LOs[LOs!=""]
# LOs <- stringr::str_replace(LOs, "- ", "")
# 
# checklist <- function(x) {
#   paste0("::: {.callout-note}\n\n", 
#          "## Reflect on learning objectives \n\n",
#          "You should be able to:\n",
#          paste0("<ul class='checkbox'>", paste(paste0("<li><input type='checkbox'> ", x, "</li>"), collapse = "\n\n"), "</ul>\n\n:::"))
#   
# }

start <- lubridate::dmy_hms("18/02/2025 11.00.00", tz = "Australia/Sydney")
timedisplay <- function(duration, time_passed = 0, loc = "Sydney") {
  start <- lubridate::with_tz(start, paste0("Australia/", loc)) + lubridate::duration(time_passed, units = "minutes")
  end <- start + lubridate::duration(duration, units = "minutes")
  ret <- paste0(format(start, "%H:%M"), "--", format(end, "%H:%M"))
  ret <- tolower(format(start, "%I:%M%p"))
  ret
}
