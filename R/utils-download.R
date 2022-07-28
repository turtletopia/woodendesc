download_repo_data <- function(url) {
  dcf_data <- NULL

  if (getRversion() >= "4.0.0") {
    packages_url <- paste(url, "PACKAGES.gz", sep = "/")
    try({
      # PACKAGES.gz may be unavailable sometimes
      dcf_data <- download_dcf(packages_url)
    }, silent = TRUE)
  }

  if (is.null(dcf_data)) {
    # Use non-gzipped PACKAGES file (it's much larger)
    packages_url <- paste(url, "PACKAGES", sep = "/")
    dcf_data <- download_dcf(packages_url, compression = "none")
  }

  read_dcf(dcf_data)
}

download_dcf <- function(url, compression = "gzip") {
  raw_response <- download_safely(url, as = "raw")
  memDecompress(raw_response, type = compression, asChar = TRUE)
}

#' @importFrom httr GET content
download_safely <- function(url, ...) {
  response <- GET(url)
  stop_for_download_fail(response, url)
  content(response, ...)
}

#' @importFrom httr stop_for_status
stop_for_download_fail <- function(response, url) {
  # Raise an exception when status code is 400 or higher
  stop_for_status(
    response,
    task = paste0("download data from ", extract_core_url(url))
  )
}
