raw_github_url <- function(...) {
  paste("https://raw.githubusercontent.com", ..., sep = "/")
}

github_url <- function(..., params = list()) {
  append_url_params(paste("https://api.github.com", ..., sep = "/"), params)
}

append_url_params <- function(url, params) {
  # Add nothing if no parameters passed
  if (length(params) == 0) return(url)

  # Wrap strings into quotation marks
  params <- lapply(params, function(p) {
    if (is.character(p)) paste0("\"", p, "\"") else p
  })
  # Translate list of parameters into URL list
  params <- paste(names(params), params, sep = "=", collapse = "&")
  # Add question mark before listing parameters
  URLencode(paste(url, params, sep = "?"))
}

extract_core_url <- function(url) {
  sub("\\?.*", "", url)
}
