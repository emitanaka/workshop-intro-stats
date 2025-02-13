library(tidyverse)
library(patchwork)
theme_set(theme_classic(base_size = 24) + 
            theme(plot.title.position = "plot",
                  plot.background = element_rect(fill = "transparent", color = "transparent"),
                  legend.background = element_rect(fill = "transparent"),
                  panel.background = element_rect(fill = "transparent")))
#options(ggplot2.discrete.fill = list(c("forestgreen", "red2")),
#        ggplot2.discrete.colour = list(c("forestgreen", "red2")))
options(ggplot2.discrete.fill  = function() colorspace::scale_fill_discrete_qualitative(),
        ggplot2.discrete.colour  = function() colorspace::scale_color_discrete_qualitative())

learning_objectives <- function(highlight = NULL) {
  lines <- readLines("_learning-objectives.qmd") |> 
    stringr::str_replace("^- ", "")
  
  lines <- lines[lines!=""]
  
  if(is.null(highlight)) highlight <- 1:length(lines) 
  
  lines <- ifelse(1:length(lines) %in% highlight, 
                  paste0("<li> <span class='fa-li'><i class='fas fa-arrow-right'></i></span>", lines, "</li>") , 
                  paste0("<li style='opacity:0.25;'><span class='fa-li'>-</span>", lines, "</li>"))
  
  cat(c('<ul class="fa-ul">',
         lines,
         '</ul>'), sep = "\n")
}

box_text <- function(id, text, fill = "#C1E1C1", index = 1, fontsize = "2em", extra = "") {
  if(index < 0) {
    return(glue::glue('<span id="box-{id}" style="background-color:{fill};border-radius: 10px;border: 3px solid black;fontsize:{fontsize};padding:10px;margin-right:20px;margin-bottom:5px;text-align:center;display:inline-block;{extra}">
             {text}
             </span>'))
  }
  glue::glue('<span id="box-{id}" style="background-color:{fill};border-radius: 10px;border: 3px solid black;fontsize:{fontsize};padding:10px;margin-right:20px;margin-bottom:5px;{extra};text-align:center;display:inline-block;" class="fragment" data-fragment-index="{index}">
             {text}
             </span>')
}

box_text_fixed <- function(text = "", width="25px", fill = glue::glue("rgba(34, 139, 34, {runif(1, 0.3, 1)})"),  fontsize = "2em", extra = "") {
    return(glue::glue('<span  style="width:{width};height:25px;background-color:{fill};border: 3px solid black;fontsize:{fontsize};padding:10px;vertical-align: middle;margin-bottom:5px;text-align:center;display:inline-block;{extra}">
             {text}
             </span>'))
}

box_text_fixed2 <- function(text = "", width="43px", fontsize = "2em", extra = "") {
  return(glue::glue('<div width="129px" style="display:inline-block;padding:10px;margin-left: 7px;"><span  style="width:{width};height:45px;background-color: rgba(34, 139, 34, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:45px;background-color:rgba(34, 139, 34, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:45px;background-color:rgba(34, 139, 34, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div>'))
}

box_matrix <- function(text = "", width="43px", fontsize = "2em", extra = "", rgb = "34, 139, 34") {
  return(glue::glue('<div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div>'))
}

box_matrix1 <- function(text = "", width="43px", fontsize = "2em", extra = "", rgb = "34, 139, 34") {
  return(glue::glue('<div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div>'))
}


box_matrix10 <- function(text = "", width="43px", fontsize = "2em", extra = "", rgb = "34, 139, 34") {
  return(glue::glue('<div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div>'))
}

box_matrix10o <- function(text = "", width="43px", fontsize = "2em", extra = "", rgb = "34, 139, 34") {
  return(glue::glue('<div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1) * 0.1});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)* 0.1});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1* 0.1)});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)* 0.1});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)* 0.1});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)* 0.1});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1) * 0.5});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1) * 0.5});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1) * 0.5});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1) * 0.5});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1) * 0.5});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1) * 0.5});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)*0.7});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)*0.7});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)*0.7});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)*0.7});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)*0.7});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)*0.7});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)*0.1});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)*0.1});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)*0.1});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)*0.8});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)*0.8});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)*0.8});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)*0.8});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)*0.8});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)*0.8});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div><div width="129px" style="margin:0;line-height:1em;padding:0;"><span  style="width:{width};height:1em;background-color: rgba({rgb}, {runif(1, 0.3, 1)*0.1});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)*0.1});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span><span  style="width:{width};height:1em;background-color:rgba({rgb}, {runif(1, 0.3, 1)*0.1});border: 3px solid black;fontsize:{fontsize};vertical-align: middle;text-align:center;display:inline-block;{extra}">
             {text}
             </span></div>'))
}



text_fixed <- function(text = "", width = "200px") {
  glue::glue('[<text>]{style="width:<width>;text-align:right;display:inline-block;margin-right:25px;"}', .open = "<", .close = ">")
}

icon_corpus <- function(id, text, pos = "", index = 1, fontsize = "5em") {
  glue::glue('<div id="corpus-{id}" style="font-size:{fontsize};position:absolute;{pos};" class="fragment" data-fragment-index="{index}">
<span class="fa-layers fa-fw">
<i class="fas fa-sticky-note" style="color:Tomato"></i>
<span class="fa-layers-text fa-inverse" style="font-size:0.2em" data-fa-transform="up-10">{text}</span>
</span>
</div>')
}



icon_data <- function(id, text, pos = "", index = 1) {
  if(index < 0) {
      return(  glue::glue('<span id="data-{id}" style="font-size:5em;position:absolute;{pos};">
<span class="fa-layers fa-fw">
<i class="fas fa-database" style="color:#008F00;"></i>
<span class="fa-layers-text" style="font-size:0.2em;width:100%;background-color:white;"  data-fa-transform="down-60">{text}</span>
</span>
</span>')
      )
  }
  glue::glue('<span id="data-{id}" style="font-size:5em;position:absolute;{pos};" class="fragment" data-fragment-index="{index}">
<span class="fa-layers fa-fw">
<i class="fas fa-database" style="color:#008F00;"></i>
<span class="fa-layers-text" style="font-size:0.2em;width:100%;background-color:white;"  data-fa-transform="down-60">{text}</span>
</span>
</span>')
  
}

icon_llm <- function(id, text, pos = "", index = 1) {
  glue::glue('<span id="llm-{id}" style="font-size:5em;position:absolute;{pos};" class="fragment" data-fragment-index="{index}">
<span class="fa-layers fa-fw">
<i class="fab fa-android" style="color:#0096FF"></i>
<span class="fa-layers-text" style="font-size:0.2em;width:100%" data-fa-transform="down-30">{text}</span>
<span class="fa-layers-text" style="font-size:0.3em;color:#0096FF" data-fa-transform="up-20">LLM</span>
</span>
</span>')
}


knitr::opts_hooks$set(include = function(options) {
  if (options$engine == "webr" || options$engine == "pyodide") {
    options$include <- TRUE
  }
  options
})

# Passthrough engine for webr
knitr::knit_engines$set(webr = function(options) {
  knitr:::one_string(c(
    "```{webr}",
    options$yaml.code,
    options$code,
    "```"
  ))
})

# Passthrough engine for pyodide
knitr::knit_engines$set(pyodide = function(options) {
  knitr:::one_string(c(
    "```{pyodide}",
    options$yaml.code,
    options$code,
    "```"
  ))
})


scroll <- '[{{< fa solid long-arrow-alt-down >}} scroll]{.f4 .absolute .top-1 .right-1}'
