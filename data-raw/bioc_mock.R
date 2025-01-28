httr2::request("https://bioconductor.org") |>
  httr2::req_url_path_append("packages", "release", "bioc", "src", "contrib", "PACKAGES.gz") |>
  httr2::req_perform() |>
  httr2::resp_body_raw() |>
  memDecompress(type = "gzip", asChar = TRUE) |>
  stringr::str_extract(stringr::regex("(?:.*?\n\n){15}", dotall = TRUE)) |>
  memCompress(type = "gzip") |>
  dput()
