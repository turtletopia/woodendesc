#' @importFrom httr GET content
download_safely <- function(url) {
  response <- GET(url)
  stop_for_download_fail(response, url)
  content(response)
}

#' @importFrom httr stop_for_status
stop_for_download_fail <- function(response, url) {
  # Raise an exception when status code is 400 or higher
  stop_for_status(
    response,
    task = paste0("download data from ", extract_core_url(url))
  )
}
