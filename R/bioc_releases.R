#' @export
wood_bioc_releases <- function() {
  bioc_releases_cache()
}

bioc_releases_cache <- function() {
  cache_file <- cache_path("releases", "bioc")

  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  response <- download_safely(bioc_url("about", "release-announcements"))
  releases <- extract_bioc_releases(response)

  saveRDS(releases, cache_file)
  # Return saved object to save time on reading it
  releases
}

extract_bioc_releases <- function(html) {
  html <- as.character(html)

  # Two-step extraction due to gregexec being available only since R 4.1.0
  codes <- regmatches(
    html,
    gregexpr("<tr>\\s*<td.*?>\\d+\\.\\d+", html, perl = TRUE)
  )[[1]]
  regmatches(
    codes,
    regexpr("\\d+\\.\\d+", codes, perl = TRUE)
  )
}
