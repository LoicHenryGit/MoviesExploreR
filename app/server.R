server <- function(input, output, session) {
  
  title_suggestions <- reactive({
    req(input$filter_title_text)
    if ((nchar(input$filter_title_text) >= 2) && (length(search_title(input$filter_title_text)) > 0)){
      search_title(input$filter_title_text) %>% 
        arrange(desc(vote_count))
    }
    else {
      NULL
    }
  })
  
  observeEvent(input$filter_title_text,{
    suggestions <- title_suggestions()
    if (nchar(input$filter_title_text) >= 2){
      if (is.null(suggestions)){
        updateSelectInput(
          session = session,
          inputId = "filter_title",
          choices = character(0)
        )
      }
      else {
        suggestions <- suggestions %>% 
          mutate(director = map_chr(id, ~ str_c(get_movie_director(.x), collapse = " / ")))
        
        movie_format <- str_c(suggestions$title, " - ",
                              suggestions$director, " (", 
                              str_sub(suggestions$release_date,1,4) ,")")
        
        updateSelectInput(
          session = session,
          inputId = "filter_title",
          choices = setNames(suggestions$id, movie_format)
        )
      }
    }
  })
  
  
  observeEvent(input$filter_director_text,{
    current_selected <- input$filter_director
    if ((nchar(input$filter_director_text) >= 2) && (length(search_person(input$filter_director_text)) > 0)){
      suggestions <- search_person(input$filter_director_text)
      if (is.null(suggestions)){
        updateSelectInput(
          session = session,
          inputId = "filter_director",
          choices = current_selected,
          selected = current_selected 
        )
      }
      else {
        updateSelectInput(
          session = session,
          inputId = "filter_director",
          choices = c(suggestions, current_selected),
          selected = current_selected 
        )
      }
    }
  })
}
