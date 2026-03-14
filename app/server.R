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
          updateSelectInput(
          session = session,
          inputId = "filter_title",
          choices = setNames(suggestions$id, str_glue("{suggestions$title} ({suggestions$release_date})"))
        )
        }
      }
    })
    
    
}
