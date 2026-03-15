setwd(dir = "~/Programmes/RepoGithub/MoviesExploreR/")

readRenviron(path = ".Renviron")

api_key <- Sys.getenv("TMDB_API_KEY")

search_title <- function(title){
  fromJSON(content(GET(str_c(
    "https://api.themoviedb.org/3/search/movie?",
    "api_key=", api_key,
    "&query=", URLencode(title),
    "&language=en-US&page=1")), "text"))$results
}

# Getting cast from a movie
get_movie_cast <- function(movie_id){
  fromJSON(content(GET(str_c(
    "https://api.themoviedb.org/3/movie/", movie_id, "/credits?",
    "api_key=", api_key)), "text"))$cast %>%
    pull(name)
}

# Getting full crew from a movie
get_movie_crew <- function(movie_id){
  fromJSON(content(GET(str_c(
    "https://api.themoviedb.org/3/movie/", movie_id, "/credits?",
    "api_key=", api_key)), "text"))$crew
  
  # If there is a crew, return the director
  if (length(crew) > 0)
    crew %>%
      select(job, name)
  # Else return empty list
  else
    list()
}

# Getting director from a movie
get_movie_director <- function(movie_id){
  # Getting full crew
  crew <- fromJSON(content(GET(str_c(
    "https://api.themoviedb.org/3/movie/", movie_id, "/credits?",
    "api_key=", api_key)), "text"))$crew
  
  # If there is a crew, return the director as a vector
  if (length(crew) > 0)
    crew %>% 
      select(name, job) %>%
      filter(job == "Director") %>% 
      pull(name)
  # Else return empty string
  else
    ""
}

search_person <- function(name_search){
  person <- fromJSON(content(GET(str_c(
    "https://api.themoviedb.org/3/search/person?",
    "api_key=", api_key,
    "&query=", URLencode(name_search))), "text"))$results
  
  if (length(person) > 0)
    person %>% 
      filter(known_for_department == "Directing") %>% 
      pull(name)
  else
    list()
}