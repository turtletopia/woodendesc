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
