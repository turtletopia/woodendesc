download_repo_data <- function(req) {
  dcf_data <- rlang::try_fetch({
    # PACKAGES.gz may be unavailable sometimes
    req |>
      httr2::req_url_path_append("PACKAGES.gz") |>
      httr2::req_perform() |>
      httr2::resp_body_raw() |>
      memDecompress(type = "gzip", asChar = TRUE)
  }, error = function(cnd) {
    # Use non-gzipped PACKAGES file (it's much larger)
    req |>
      httr2::req_url_path_append("PACKAGES") |>
      httr2::req_perform() |>
      httr2::resp_body_raw() |>
      memDecompress(type = "none", asChar = TRUE)
  })

  read_dcf(dcf_data)
}

paginate <- function(url, ..., .per_page = 100) {
  # TODO: use httr2::req_perform_iterative()
  ret <- list()
  page <- 1
  while (TRUE) {
    url <- append_url_params(url, list(per_page = .per_page, page = page))
    content <- download_safely(url, ...)
    # Append result
    ret <- c(ret, content)
    # Stop iterating if the last page
    if (length(content) != .per_page) break
    page <- page + 1
  }
  ret
}

#' @importFrom httr GET content
download_safely <- function(url, ..., on_status = list()) {
  response <- GET(url)
  stop_for_download_fail(response, url, on_status)
  content(response, ...)
}

#' @importFrom httr stop_for_status status_code
stop_for_download_fail <- function(response, url, on_status = list()) {
  response_status <- as.character(status_code(response))

  if (response_status %in% names(on_status)) {
    # Trigger a custom handler
    # Could potentially take response as a parameter
    on_status[[response_status]]()
  } else {
    # Raise an exception when status code is 400 or higher
    stop_for_status(
      response,
      task = paste0("download data from ", extract_core_url(url))
    )
  }
}
