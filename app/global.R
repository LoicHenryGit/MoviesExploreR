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

# movies_list <- fromJSON(content(GET(paste0(
#   "https://api.themoviedb.org/3/discover/movie?",
#   "api_key=", api_key, "&page=2")), "text"))

