# ui <- fluidPage(
#   
#   # Title
#   titlePanel("MoviesExploreR"),
#   
#   # Movies research
#   
#   # Filter by title
# #   fluidRow(
# #     column(2),
# #     column(10,
# #     textInput(inputId = "filter_title_text",
# #               label = "Start typing title here"),
# #     selectInput(inputId = "filter_title",
# #                 label = "Choose matching movie(s) here",
# #                 choices = NULL,
# #                 multiple = TRUE)
# #     )
# #
# # )
# # # Filter for movie director
# # column(4, align = "center",
# #        selectizeInput(inputId = "filter_director",
# #                       label = "Director : ",
# #                       choices = NULL,
# #                       multiple = TRUE,
# #                       width = "100%",
# #                       options = list(plugins = list('restore_on_backspace')))
# # ),
# #
# # # Filter for movie screenwriter
# # column(4, align = "center",
# #        selectizeInput(inputId = "filter_screenwriter",
# #                       label = "Screenwriter : ",
# #                       choices = NULL,
# #                       multiple = TRUE,
# #                       width = "100%",
# #                       options = list(plugins = list('restore_on_backspace')))
# # )
# # ),
# 
# # fluidRow(
# #
# #   # Filter for movie composer
# #   column(4, align = "center",
# #          selectizeInput(inputId = "filter_composer",
# #                         label = "Composer : ",
# #                         choices = NULL,
# #                         multiple = TRUE,
# #                         width = "100%",
# #                         options = list(plugins = list('restore_on_backspace')))
# #   ),
# #
# #   # Filter for movie cinematographer
# #   column(4, align = "center",
# #          selectizeInput(inputId = "filter_cinematographer",
# #                         label = "Cinematographer : ",
# #                         choices = NULL,
# #                         multiple = TRUE,
# #                         width = "100%",
# #                         options = list(plugins = list('restore_on_backspace')))
# #   ),
# #
# #   # Filter for movie producer
# #   column(4, align = "center",
# #          selectizeInput(inputId = "filter_producer",
# #                         label = "Producer : ",
# #                         choices = NULL,
# #                         multiple = TRUE,
# #                         width = "100%",
# #                         options = list(plugins = list('restore_on_backspace')))
# #   )
# # ),
# #
# # fluidRow(
# #
# #   # Filter for movie keywords
# #   column(3, align = "center",
# #          selectizeInput(inputId = "filter_keywords",
# #                         label = "Keywords : ",
# #                         choices = NULL,
# #                         multiple = TRUE,
# #                         options = list(plugins = list('restore_on_backspace')))
# #   ),
# #
# #   # Filter for movie genre
# #   column(3, align = "center",
# #          selectizeInput("filter_genres",
# #                         label = "Genre : ",
# #                         choices = NULL,
# #                         multiple = TRUE,
# #                         options = list(plugins = list('restore_on_backspace')))
# #   ),
# #
# #   # Filter for movie rating
# #   column(3, align = "center",
# #          numericInput("filter_min_rating",
# #                       label = "Minimum rating :",
# #                       min = 0,
# #                       max = 10,
# #                       step = 0.1,
# #                       value = 0)
# #   ),
# #
# #   # Filter for movie number of votes
# #   column(3, align = "center",
# #          numericInput(inputId = "filter_min_votes",
# #                       label = "Minimum votes :",
# #                       min = 0,
# #                       max = NA,
# #                       step = 1,
# #                       value = 50)
# #   )
# # ),
# #
# #   # Search launch button
# #   fluidRow(
# #     column(12, align = "center",
# #            actionButton("filter_button", "Search"))
# #   ),
# #
# #   # Search results table
# #   fluidRow(
# #     column(12, align = "center",
# #            dataTableOutput("filter_result"))
# #   )
# # )

ui <- fluidPage(
  titlePanel("MoviesExploreR"),
  
  sidebarLayout(sidebarPanel(width = 4,
                             # Title Search (always visible)
                             h4("🔍 Title"),
                             textInput(inputId = "filter_title_text",
                                       label = "Start typing title here"),
                             selectInput(inputId = "filter_title",
                                         label = "Choose matching movie(s) here",
                                         choices = NULL,
                                         multiple = TRUE),
                             
                             hr(),
                             
                             # People Filters
                             h4("👥 People"),
                             textInput("director_search", "Director:"),
                             textInput("cinematographer_search", "Cinematographer:"),
                             textInput("composer_search", "Composer:"),
                             
                             hr(),
                             
                             # Release & Ratings
                             h4("📅 Release & Ratings"),
                             numericInput("min_rating", "Min Rating:", min = 0, max = 10, value = 6),
                             dateRangeInput("release_dates", "Release Period:", start = NULL, end = NULL),
                             
                             hr(),
                             
                             actionButton("search_btn", "🔍 Search", class = "btn-primary")
  ),
  
  mainPanel(width = 8,
            verbatimTextOutput("debug"),
            uiOutput("results")
  )
  )
)