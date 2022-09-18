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
